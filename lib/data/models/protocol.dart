import 'package:isar/isar.dart';

part 'protocol.g.dart';

/// Protocol Model - Represents goals/targets (like GitHub Actions)
/// Protocols define rules and targets for task completion
@collection
class Protocol {
  Id id = Isar.autoIncrement;

  /// Protocol name (e.g., "Learn German by June", "365 Day Workout")
  @Index()
  late String name;

  /// Target number of commits per week
  late int weeklyTarget;

  /// JSON conditions for completion (flexible rules)
  String? conditions;

  /// Target deadline
  DateTime? deadline;

  /// What happens on failure (JSON rules)
  String? failureRules;

  /// Color theme: "green", "blue", "purple", "orange", "custom"
  late String colorTheme;

  /// Custom color if colorTheme is "custom"
  String? customColorHex;

  /// Creation timestamp
  @Index()
  late DateTime createdAt;

  /// Whether this protocol is currently active
  @Index()
  bool isActive = true;

  /// Description of the protocol
  String? description;

  /// Task IDs linked to this protocol
  List<int> linkedTaskIds = [];

  /// Current progress percentage (0-100)
  double progressPercent = 0.0;

  /// Total commits under this protocol
  int totalCommits = 0;

  /// Weeks completed successfully
  int successfulWeeks = 0;

  /// Weeks failed
  int failedWeeks = 0;

  Protocol();

  /// Create a new protocol
  Protocol.create({
    required this.name,
    required this.weeklyTarget,
    this.colorTheme = 'green',
    this.deadline,
    this.description,
    this.conditions,
    this.failureRules,
    this.linkedTaskIds = const [],
  }) : createdAt = DateTime.now();

  /// Check if protocol is overdue
  bool get isOverdue {
    if (deadline == null) return false;
    return DateTime.now().isAfter(deadline!);
  }

  /// Days remaining until deadline
  int? get daysRemaining {
    if (deadline == null) return null;
    return deadline!.difference(DateTime.now()).inDays;
  }

  /// Whether goal is achieved
  bool get isAchieved => progressPercent >= 100;
}
