import 'package:isar/isar.dart';

part 'protocol.g.dart';

enum ProtocolFrequency { daily, weekly, custom }

@collection
class Protocol {
  Id id = Isar.autoIncrement;

  String title;
  String? description;
  String colorHex;

  // Schedule
  @Enumerated(EnumType.ordinal)
  ProtocolFrequency frequency;

  // Days of week for weekly/custom (0 = Monday, 6 = Sunday)
  List<int> daysOfWeek;

  // Time in minutes from midnight (e.g. 9:00 AM = 540)
  int? reminderTime;

  // Tracking
  int currentStreak;
  int longestStreak;
  int totalCompletions;
  DateTime? lastCompletedAt;

  bool isActive;
  DateTime createdAt;

  Protocol({
    required this.title,
    this.description,
    required this.colorHex,
    required this.frequency,
    this.daysOfWeek = const [],
    this.reminderTime,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalCompletions = 0,
    this.lastCompletedAt,
    this.isActive = true,
  }) : createdAt = DateTime.now();
}
