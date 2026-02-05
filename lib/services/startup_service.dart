import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage Windows startup behavior
class StartupService {
  static const _prefKey = 'start_on_startup';
  
  /// Check if app is set to start on Windows startup
  static Future<bool> isStartupEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefKey) ?? false;
  }

  /// Enable or disable startup with Windows
  static Future<bool> setStartupEnabled(bool enabled) async {
    try {
      final exePath = Platform.resolvedExecutable;
      final appName = 'Arvion';
      
      if (enabled) {
        // Add to Windows startup via registry
        final result = await Process.run('reg', [
          'add',
          r'HKCU\Software\Microsoft\Windows\CurrentVersion\Run',
          '/v', appName,
          '/t', 'REG_SZ',
          '/d', '"$exePath"',
          '/f'
        ]);
        
        if (result.exitCode != 0) {
          print('Failed to add startup: ${result.stderr}');
          return false;
        }
      } else {
        // Remove from Windows startup
        final result = await Process.run('reg', [
          'delete',
          r'HKCU\Software\Microsoft\Windows\CurrentVersion\Run',
          '/v', appName,
          '/f'
        ]);
        
        // Exit code 1 is OK - means key didn't exist
        if (result.exitCode != 0 && result.exitCode != 1) {
          print('Failed to remove startup: ${result.stderr}');
          return false;
        }
      }
      
      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefKey, enabled);
      return true;
    } catch (e) {
      print('Startup service error: $e');
      return false;
    }
  }
}
