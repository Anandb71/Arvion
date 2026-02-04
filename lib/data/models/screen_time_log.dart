import 'package:isar/isar.dart';

part 'screen_time_log.g.dart';

/// Screen Time Log Model - Tracks application usage
@collection
class ScreenTimeLog {
  Id id = Isar.autoIncrement;

  /// When this sample was recorded
  @Index()
  late DateTime timestamp;

  /// Application name (e.g., "Visual Studio Code", "Chrome")
  @Index()
  late String appName;

  /// Window title at time of sample
  late String windowTitle;

  /// Duration of this sample in seconds (typically 30)
  late int durationSeconds;

  /// Whether user was active (vs idle)
  bool isActive = true;

  /// Day index for efficient querying (days since epoch)
  @Index()
  int get dayIndex => timestamp.difference(DateTime(1970, 1, 1)).inDays;

  /// Hour of day (0-23)
  int get hourOfDay => timestamp.hour;

  /// Year for grouping
  int get year => timestamp.year;

  /// Month for grouping
  int get month => timestamp.month;

  ScreenTimeLog();

  /// Create a new screen time log entry
  ScreenTimeLog.create({
    required this.appName,
    required this.windowTitle,
    required this.durationSeconds,
    this.isActive = true,
  }) : timestamp = DateTime.now();
}
