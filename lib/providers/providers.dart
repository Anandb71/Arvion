import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/data_export_service.dart';
import '../services/ai_service.dart';
import '../services/verification_service.dart';
import '../data/database/isar_database.dart';
import '../data/repositories/task_repository.dart';
import '../data/repositories/commit_repository.dart';
import '../data/repositories/protocol_repository.dart';
import '../data/models/task.dart';
import '../data/models/commit.dart';
import '../data/models/protocol.dart';
import '../data/models/insights.dart';

// ============================================================================
// Database Provider
// ============================================================================

/// Provider for database initialization state
final databaseInitializedProvider = FutureProvider<bool>((ref) async {
  await IsarDatabase.initialize();
  return true;
});

// ============================================================================
// Repository Providers
// ============================================================================

/// Task repository provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository();
});

/// Commit repository provider
final commitRepositoryProvider = Provider<CommitRepository>((ref) {
  return CommitRepository();
});

/// Protocol repository provider
final protocolRepositoryProvider = Provider<ProtocolRepository>((ref) {
  return ProtocolRepository();
});

// ============================================================================
// Task Providers
// ============================================================================

/// Stream of all active tasks
final activeTasksProvider = StreamProvider<List<Task>>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchAllActive();
});

/// Stream of all active protocols
final activeProtocolsProvider = StreamProvider<List<Protocol>>((ref) {
  final repo = ref.watch(protocolRepositoryProvider);
  return repo.watchAllActive();
});

/// Currently selected task for detail view
final selectedTaskProvider = StateProvider<Task?>((ref) => null);

/// Search query for tasks
final taskSearchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered tasks based on search query
final filteredTasksProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final tasksAsync = ref.watch(activeTasksProvider);
  final query = ref.watch(taskSearchQueryProvider).toLowerCase();

  return tasksAsync.when(
    data: (tasks) {
      if (query.isEmpty) return AsyncValue.data(tasks);
      final filtered = tasks
          .where((t) =>
              t.title.toLowerCase().contains(query) ||
              t.tags.any((tag) => tag.toLowerCase().contains(query)))
          .toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

// ============================================================================
// Commit Providers
// ============================================================================

/// Stream of today's commits - auto-updates!
final todayCommitsProvider = StreamProvider<List<Commit>>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  return repo.watchToday();
});

/// Recent commits (last 10)
final recentCommitsProvider = FutureProvider<List<Commit>>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  return repo.getRecent(limit: 10);
});

/// Today's commit count - derived from stream for auto-updates!
final todayCommitCountProvider = Provider<AsyncValue<int>>((ref) {
  final todayCommits = ref.watch(todayCommitsProvider);
  return todayCommits.whenData((commits) => commits.length);
});

/// Heatmap data provider - with task colors for multi-color support
final heatmapDataProvider = StreamProvider<Map<int, HeatmapCellInfo>>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  final taskRepo = ref.watch(taskRepositoryProvider);
  return repo.watchHeatmapWithTasks(taskRepo: taskRepo, weeks: 52);
});

/// Simple heatmap for intensity only (backward compatible)
final simpleHeatmapProvider = StreamProvider<Map<int, int>>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  return repo.watchHeatmapData(weeks: 52);
});

/// Per-task heatmaps - separate heatmap for each task
final perTaskHeatmapsProvider = StreamProvider<Map<int, TaskHeatmapData>>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  final taskRepo = ref.watch(taskRepositoryProvider);
  return repo.watchPerTaskHeatmaps(taskRepo: taskRepo, weeks: 52);
});

/// This week's commit count
final weekCommitCountProvider = FutureProvider<int>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  return repo.getThisWeekCount();
});

/// Total commit count - stream for real-time updates
final totalCommitCountProvider = StreamProvider<int>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  return repo.watchTotalCount();
});

// ============================================================================
// Protocol Providers
// ============================================================================

/// Stream of active protocols
// ============================================================================
// Protocol Providers
// ============================================================================

/// Currently selected protocol
final selectedProtocolProvider = StateProvider<Protocol?>((ref) => null);

// ============================================================================
// UI State Providers
// ============================================================================

/// Current navigation index
final navigationIndexProvider = StateProvider<int>((ref) => 0);

/// Command palette visibility
final commandPaletteVisibleProvider = StateProvider<bool>((ref) => false);

/// Selected date for detail view
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

// ============================================================================
// Heatmap Cell Info - Multi-color support
// ============================================================================

/// Information about a single heatmap cell with multi-task support
class HeatmapCellInfo {
  final int totalIntensity;
  final List<TaskContribution> contributions;

  const HeatmapCellInfo({
    required this.totalIntensity,
    this.contributions = const [],
  });

  /// Get the dominant color (task with most intensity)
  String? get dominantColorHex {
    if (contributions.isEmpty) return null;
    contributions.sort((a, b) => b.intensity.compareTo(a.intensity));
    return contributions.first.colorHex;
  }

  /// Get all colors for multi-color rendering
  List<String> get colors => contributions.map((c) => c.colorHex).toList();
}

/// A task's contribution to a day
class TaskContribution {
  final int taskId;
  final String colorHex;
  final int intensity;
  final String taskTitle;

  const TaskContribution({
    required this.taskId,
    required this.colorHex,
    required this.intensity,
    required this.taskTitle,
  });
}

/// Per-task heatmap data
class TaskHeatmapData {
  final int taskId;
  final String taskTitle;
  final String colorHex;
  final Map<int, int> data; // dayIndex -> intensity
  final int totalCommits;

  const TaskHeatmapData({
    required this.taskId,
    required this.taskTitle,
    required this.colorHex,
    required this.data,
    required this.totalCommits,
  });
}

// ============================================================================
// Insights Providers
// ============================================================================

/// Weekly activity chart data
final weeklyActivityProvider = StreamProvider<List<WeeklyActivity>>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  return repo.watchWeeklyActivity();
});

/// Insight patterns data
final insightPatternsProvider = StreamProvider<InsightPatterns>((ref) {
  final repo = ref.watch(commitRepositoryProvider);
  return repo.watchInsightPatterns();
});

/// Data Export Service provider
final dataExportServiceProvider = Provider<DataExportService>((ref) {
  return DataExportService(
    taskRepo: ref.watch(taskRepositoryProvider),
    commitRepo: ref.watch(commitRepositoryProvider),
    protocolRepo: ref.watch(protocolRepositoryProvider),
  );
});

/// AI Service provider
final aiServiceProvider = Provider<AIService>((ref) {
  return AIService(
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});

/// Verification Service provider (Auto-starts monitoring)
final verificationServiceProvider = Provider<VerificationService>((ref) {
  final service = VerificationService(
    taskRepository: ref.watch(taskRepositoryProvider),
    commitRepository: ref.watch(commitRepositoryProvider),
  );
  // Auto-start only in release/debug run (not tests)
  service.start();
  ref.onDispose(() => service.stop());
  return service;
});
