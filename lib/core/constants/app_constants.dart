/// App-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Arvion';
  static const String appTagline = 'A contribution graph for your life';
  static const String appVersion = '1.0.0';

  // Heatmap Configuration
  static const int heatmapCellSize = 12;
  static const int heatmapCellGap = 3;
  static const int heatmapCellRadius = 3;
  static const int heatmapWeeksToShow = 52;
  static const int heatmapDaysPerWeek = 7;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration heatmapCompileAnimation = Duration(milliseconds: 800);

  // Intensity Levels
  static const int maxIntensity = 5;
  static const int minIntensity = 1;

  // Keyboard Shortcuts
  static const String commandPaletteShortcut = 'Ctrl+K';
  static const String newTaskShortcut = 'Ctrl+N';
  static const String quickCommitShortcut = 'Ctrl+Enter';

  // Database
  static const String databaseName = 'arvion_db';

  // Verification Types
  static const List<String> verificationTypes = [
    'manual',
    'gps',
    'app_usage',
    'notification',
    'timer',
  ];

  // Difficulty Levels
  static const Map<int, String> difficultyLabels = {
    1: 'Trivial',
    2: 'Easy',
    3: 'Medium',
    4: 'Hard',
    5: 'Epic',
  };

  // Protocol Color Themes
  static const List<String> protocolThemes = [
    'green',
    'blue',
    'purple',
    'orange',
    'custom',
  ];
}
