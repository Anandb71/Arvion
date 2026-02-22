import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';
import '../data/repositories/screen_time_repository.dart';

/// Service to monitor screen time automatically
class ScreenTimeService {
  final ScreenTimeRepository repository;
  Timer? _timer;
  bool _isRunning = false;

  // Config
  static const _pollIntervalSeconds = 30; // Sample every 30 seconds
  static const _idleThresholdMillis = 60000; // 1 minute idle = inactive

  ScreenTimeService({required this.repository});

  /// Start monitoring screen time
  void start() {
    if (_isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(
      const Duration(seconds: _pollIntervalSeconds),
      (_) => _recordActivity(),
    );
  }

  /// Stop monitoring
  void stop() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
  }

  /// Record current activity
  Future<void> _recordActivity() async {
    try {
      final windowInfo = _getCurrentWindowInfo();
      final isActive = _isUserActive();

      await repository.logActivity(
        appName: windowInfo.appName,
        windowTitle: windowInfo.windowTitle,
        durationSeconds: _pollIntervalSeconds,
        isActive: isActive,
      );
    } catch (e) {
      // Silently fail - don't crash the app
      print('Screen time logging error: $e');
    }
  }

  /// Get current foreground window information
  _WindowInfo _getCurrentWindowInfo() {
    try {
      final hwnd = GetForegroundWindow();
      if (hwnd == 0) {
        return _WindowInfo(appName: 'Unknown', windowTitle: '');
      }

      // Get window title
      final titleBuffer = wsalloc(256);
      final titleLength = GetWindowText(hwnd, titleBuffer, 256);
      final windowTitle = titleLength > 0 ? titleBuffer.toDartString() : '';
      free(titleBuffer);

      // Extract app name from window title or use generic
      final appName = _extractAppName(windowTitle);

      return _WindowInfo(appName: appName, windowTitle: windowTitle);
    } catch (e) {
      return _WindowInfo(appName: 'Error', windowTitle: '');
    }
  }

  /// Extract app name from window title
  String _extractAppName(String windowTitle) {
    if (windowTitle.isEmpty) return 'Unknown';
    final lowerTitle = windowTitle.toLowerCase();

    // Common patterns
    if (lowerTitle.contains('visual studio code') ||
        lowerTitle.contains('vscode')) {
      // Optional: Extract project name if needed, but for now keep it simple to avoid clutter
      return 'VS Code';
    }
    if (lowerTitle.contains('chrome')) return 'Chrome';
    if (lowerTitle.contains('firefox')) return 'Firefox';
    if (lowerTitle.contains('edge')) return 'Edge';
    if (lowerTitle.contains('discord')) return 'Discord';
    if (lowerTitle.contains('spotify')) return 'Spotify';
    if (lowerTitle.contains('slack')) return 'Slack';

    // Self-detection
    if (lowerTitle.contains('arvion')) return 'Arvion';
    if (lowerTitle.contains('antigravity')) return 'Antigravity';

    // If it has a dash, take the last part (common pattern: "Title - App Name")
    if (windowTitle.contains(' - ')) {
      final parts = windowTitle.split(' - ');
      return parts.last.trim();
    }

    // Otherwise use first 20 chars
    return windowTitle.length > 20
        ? '${windowTitle.substring(0, 20)}...'
        : windowTitle;
  }

  /// Check if user is currently active (not idle)
  bool _isUserActive() {
    try {
      final lastInputInfo = calloc<LASTINPUTINFO>();
      lastInputInfo.ref.cbSize = sizeOf<LASTINPUTINFO>();

      if (GetLastInputInfo(lastInputInfo) != 0) {
        final lastInputTick = lastInputInfo.ref.dwTime;
        final currentTick = GetTickCount();
        final idleTime = currentTick - lastInputTick;

        calloc.free(lastInputInfo);
        return idleTime < _idleThresholdMillis;
      }

      calloc.free(lastInputInfo);
      return true; // Assume active if we can't determine
    } catch (e) {
      return true; // Assume active on error
    }
  }
}

class _WindowInfo {
  final String appName;
  final String windowTitle;

  _WindowInfo({required this.appName, required this.windowTitle});
}
