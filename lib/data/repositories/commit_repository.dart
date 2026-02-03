import 'package:isar/isar.dart';
import '../models/commit.dart';
import '../models/task.dart';
import '../database/isar_database.dart';
import 'task_repository.dart';
import '../../providers/providers.dart';

/// Repository for Commit operations
class CommitRepository {
  Isar get _isar => IsarDatabase.instance;
  IsarCollection<Commit> get _commits => _isar.commits;

  /// Watch all commits as a stream
  Stream<List<Commit>> watchAll() {
    return _commits.where().sortByTimestampDesc().watch(fireImmediately: true);
  }

  /// Watch today's commits
  Stream<List<Commit>> watchToday() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _commits
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .sortByTimestampDesc()
        .watch(fireImmediately: true);
  }

  /// Watch total count for real-time updates
  Stream<int> watchTotalCount() {
    return _commits.watchLazy(fireImmediately: true).asyncMap((_) async {
      return await _commits.count();
    });
  }

  /// Watch heatmap data as a stream (intensity only)
  Stream<Map<int, int>> watchHeatmapData({int weeks = 52}) {
    return _commits.watchLazy(fireImmediately: true).asyncMap((_) async {
      return await getHeatmapData(weeks: weeks);
    });
  }

  /// Watch heatmap with task color information for multi-color cells
  Stream<Map<int, HeatmapCellInfo>> watchHeatmapWithTasks({
    required TaskRepository taskRepo,
    int weeks = 52,
  }) {
    return _commits.watchLazy(fireImmediately: true).asyncMap((_) async {
      final now = DateTime.now();
      final startDate = now.subtract(Duration(days: weeks * 7));

      final commits = await _commits
          .filter()
          .timestampGreaterThan(startDate)
          .findAll();

      // Get all tasks for color lookup
      final tasks = await taskRepo.getAll();
      final taskMap = {for (var t in tasks) t.id: t};

      // Group commits by day
      final heatmap = <int, HeatmapCellInfo>{};
      final dayContributions = <int, Map<int, int>>{}; // dayIndex -> {taskId: intensity}

      for (final commit in commits) {
        final dayIndex = commit.dayIndex;
        dayContributions.putIfAbsent(dayIndex, () => {});

        if (commit.taskIds.isEmpty) {
          // Commit without task - use a default "general" entry
          dayContributions[dayIndex]![-1] =
              (dayContributions[dayIndex]![-1] ?? 0) + commit.intensity;
        } else {
          for (final taskId in commit.taskIds) {
            dayContributions[dayIndex]![taskId] =
                (dayContributions[dayIndex]![taskId] ?? 0) + commit.intensity;
          }
        }
      }

      // Convert to HeatmapCellInfo with colors
      for (final entry in dayContributions.entries) {
        final dayIndex = entry.key;
        final taskIntensities = entry.value;
        
        int totalIntensity = 0;
        final contributions = <TaskContribution>[];

        for (final taskEntry in taskIntensities.entries) {
          final taskId = taskEntry.key;
          final intensity = taskEntry.value;
          totalIntensity += intensity;

          if (taskId == -1) {
            // General commit (no task)
            contributions.add(TaskContribution(
              taskId: -1,
              colorHex: '#00D26A', // Default green
              intensity: intensity,
              taskTitle: 'General',
            ));
          } else {
            final task = taskMap[taskId];
            if (task != null) {
              contributions.add(TaskContribution(
                taskId: taskId,
                colorHex: task.colorHex,
                intensity: intensity,
                taskTitle: task.title,
              ));
            }
          }
        }

        heatmap[dayIndex] = HeatmapCellInfo(
          totalIntensity: totalIntensity.clamp(0, 5),
          contributions: contributions,
        );
      }

      return heatmap;
    });
  }

  /// Watch per-task heatmaps - separate heatmap for each task
  Stream<Map<int, TaskHeatmapData>> watchPerTaskHeatmaps({
    required TaskRepository taskRepo,
    int weeks = 52,
  }) {
    return _commits.watchLazy(fireImmediately: true).asyncMap((_) async {
      final now = DateTime.now();
      final startDate = now.subtract(Duration(days: weeks * 7));

      final commits = await _commits
          .filter()
          .timestampGreaterThan(startDate)
          .findAll();

      // Get all tasks
      final tasks = await taskRepo.getAll();
      final taskMap = {for (var t in tasks) t.id: t};

      // Group commits by task
      final taskHeatmaps = <int, Map<int, int>>{}; // taskId -> {dayIndex: intensity}
      final taskCommitCounts = <int, int>{};

      for (final commit in commits) {
        final dayIndex = commit.dayIndex;

        for (final taskId in commit.taskIds) {
          taskHeatmaps.putIfAbsent(taskId, () => {});
          taskHeatmaps[taskId]![dayIndex] =
              (taskHeatmaps[taskId]![dayIndex] ?? 0) + commit.intensity;
          taskCommitCounts[taskId] = (taskCommitCounts[taskId] ?? 0) + 1;
        }
      }

      // Convert to TaskHeatmapData
      final result = <int, TaskHeatmapData>{};
      for (final entry in taskHeatmaps.entries) {
        final taskId = entry.key;
        final task = taskMap[taskId];
        if (task != null) {
          // Cap intensities at 5
          final cappedData = entry.value.map(
            (dayIndex, intensity) => MapEntry(dayIndex, intensity.clamp(0, 5)),
          );
          result[taskId] = TaskHeatmapData(
            taskId: taskId,
            taskTitle: task.title,
            colorHex: task.colorHex,
            data: cappedData,
            totalCommits: taskCommitCounts[taskId] ?? 0,
          );
        }
      }

      return result;
    });
  }

  /// Get commits for a specific day
  Future<List<Commit>> getByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _commits
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .sortByTimestampDesc()
        .findAll();
  }

  /// Get commits for a date range
  Future<List<Commit>> getByDateRange(DateTime start, DateTime end) {
    return _commits
        .filter()
        .timestampBetween(start, end)
        .sortByTimestampDesc()
        .findAll();
  }

  /// Get commits for a task
  Future<List<Commit>> getByTaskId(int taskId) {
    return _commits
        .filter()
        .taskIdsElementEqualTo(taskId)
        .sortByTimestampDesc()
        .findAll();
  }

  /// Get heatmap data for past N weeks
  Future<Map<int, int>> getHeatmapData({int weeks = 52}) async {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: weeks * 7));

    final commits = await _commits
        .filter()
        .timestampGreaterThan(startDate)
        .findAll();

    // Group by day index and calculate intensity
    final heatmap = <int, int>{};
    for (final commit in commits) {
      final dayIndex = commit.dayIndex;
      heatmap[dayIndex] = (heatmap[dayIndex] ?? 0) + commit.intensity;
    }

    // Cap intensity at 5
    return heatmap.map((key, value) => MapEntry(key, value.clamp(0, 5)));
  }

  /// Get commit by ID
  Future<Commit?> getById(int id) {
    return _commits.get(id);
  }

  /// Create a new commit
  Future<int> create(Commit commit) {
    return _isar.writeTxn(() => _commits.put(commit));
  }

  /// Update a commit
  Future<int> update(Commit commit) {
    return _isar.writeTxn(() => _commits.put(commit));
  }

  /// Delete a commit
  Future<bool> delete(int id) {
    return _isar.writeTxn(() => _commits.delete(id));
  }

  /// Get total commits count
  Future<int> getTotalCount() {
    return _commits.count();
  }

  /// Get commits count for today
  Future<int> getTodayCount() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _commits
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .count();
  }

  /// Get commits count for this week
  Future<int> getThisWeekCount() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    return _commits.filter().timestampGreaterThan(start).count();
  }

  /// Get recent commits (limited)
  Future<List<Commit>> getRecent({int limit = 10}) {
    return _commits.where().sortByTimestampDesc().limit(limit).findAll();
  }
}
