import 'package:isar/isar.dart';

part 'commit.g.dart';

/// Commit Model - Represents completed actions/contributions
/// Each commit is a logged activity for a task
@collection
class Commit {
  Id id = Isar.autoIncrement;

  /// When the commit was made
  @Index()
  late DateTime timestamp;

  /// Intensity level 1-5 (affects heatmap color depth)
  late int intensity;

  /// How the commit was verified
  @enumerated
  late CommitSource source;

  /// Confidence level 0.0 - 1.0 (for auto-detected commits)
  double confidence = 1.0;

  /// IDs of tasks completed in this commit
  @Index()
  List<int> taskIds = [];

  /// Optional metadata in JSON format
  String? metadata;

  /// Optional note from user
  String? note;

  /// Duration in minutes (if applicable)
  int? durationMinutes;

  /// Day index for efficient querying (days since epoch)
  @Index()
  int get dayIndex => timestamp.difference(DateTime(1970, 1, 1)).inDays;

  /// Year for grouping
  int get year => timestamp.year;

  /// Month for grouping
  int get month => timestamp.month;

  /// Week number for grouping
  int get weekOfYear {
    final firstDayOfYear = DateTime(timestamp.year, 1, 1);
    final days = timestamp.difference(firstDayOfYear).inDays;
    return ((days + firstDayOfYear.weekday) / 7).ceil();
  }

  Commit();

  /// Create a new commit
  Commit.create({
    required this.taskIds,
    required this.intensity,
    this.source = CommitSource.manual,
    this.confidence = 1.0,
    this.note,
    this.durationMinutes,
    this.metadata,
  }) : timestamp = DateTime.now();

  /// Create a quick commit for a single task
  factory Commit.quick(int taskId, {int intensity = 3, String? note}) {
    return Commit.create(
      taskIds: [taskId],
      intensity: intensity,
      note: note,
    );
  }
}

/// Source of the commit verification
enum CommitSource {
  manual,
  gps,
  appUsage,
  notification,
  timer,
  auto,
}
