import 'package:isar/isar.dart';

part 'task.g.dart';

/// Task Model - Represents a "Repository" in the Git for Life metaphor
/// Each task is something the user wants to track and commit to
@collection
class Task {
  Id id = Isar.autoIncrement;

  /// Task title (e.g., "Learn German", "Morning Workout")
  @Index()
  late String title;

  /// Category color in hex format (e.g., "#00D26A")
  late String colorHex;

  /// How to verify task completion
  /// Options: "manual", "gps", "app_usage", "notification", "timer"
  @enumerated
  late VerificationType verificationType;

  /// JSON config for verification (e.g., GPS coordinates, app package name)
  String? verificationConfig;

  /// Difficulty level 1-5
  late int difficulty;

  /// Tags for categorization
  List<String> tags = [];

  /// Link to a Protocol (goal) if applicable
  int? protocolId;

  /// Creation timestamp
  @Index()
  late DateTime createdAt;

  /// Last activity timestamp
  DateTime? lastActivityAt;

  /// Whether this task is archived
  @Index()
  bool isArchived = false;

  /// Total commits for this task
  int totalCommits = 0;

  /// Current streak in days
  int currentStreak = 0;

  /// Longest streak ever achieved
  int longestStreak = 0;

  /// Optional description
  String? description;

  /// Optional icon (emoji or icon name)
  String? icon;

  Task();

  /// Create a new task with required fields
  Task.create({
    required this.title,
    required this.colorHex,
    this.verificationType = VerificationType.manual,
    this.difficulty = 2,
    this.tags = const [],
    this.description,
    this.icon,
  }) : createdAt = DateTime.now();
}

/// Verification types for tasks
enum VerificationType {
  manual,
  gps,
  appUsage,
  notification,
  timer,
}
