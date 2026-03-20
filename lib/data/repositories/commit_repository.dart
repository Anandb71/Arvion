import 'package:isar/isar.dart';
import '../models/commit.dart';
import '../database/isar_database.dart';
import 'task_repository.dart';
import '../../providers/providers.dart';
import '../models/insights.dart';

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
      final dayContributions =
          <int, Map<int, int>>{}; // dayIndex -> {taskId: intensity}

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
            contributions.add(
              TaskContribution(
                taskId: -1,
                colorHex: '#00D26A', // Default green
                intensity: intensity,
                taskTitle: 'General',
              ),
            );
          } else {
            final task = taskMap[taskId];
            if (task != null) {
              contributions.add(
                TaskContribution(
                  taskId: taskId,
                  colorHex: task.colorHex,
                  intensity: intensity,
                  taskTitle: task.title,
                ),
              );
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

      // Get ONLY active tasks (not deleted, not archived)
      final tasks = await taskRepo.getAllActive();
      final taskMap = {for (var t in tasks) t.id: t};

      // Group commits by task - only for tasks that still exist
      final taskHeatmaps =
          <int, Map<int, int>>{}; // taskId -> {dayIndex: intensity}
      final taskCommitCounts = <int, int>{};

      for (final commit in commits) {
        final dayIndex = commit.dayIndex;

        for (final taskId in commit.taskIds) {
          // Skip if task no longer exists
          if (!taskMap.containsKey(taskId)) continue;

          taskHeatmaps.putIfAbsent(taskId, () => {});
          taskHeatmaps[taskId]![dayIndex] =
              (taskHeatmaps[taskId]![dayIndex] ?? 0) + commit.intensity;
          taskCommitCounts[taskId] = (taskCommitCounts[taskId] ?? 0) + 1;
        }
      }

      // Convert to TaskHeatmapData - only for existing tasks
      final result = <int, TaskHeatmapData>{};
      for (final entry in taskHeatmaps.entries) {
        final taskId = entry.key;
        final task = taskMap[taskId];
        // Double-check task exists (should always be true due to filter above)
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

    return _commits.filter().timestampBetween(startOfDay, endOfDay).count();
  }

  /// Get commits count for this week
  Future<int> getThisWeekCount() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );

    return _commits.filter().timestampGreaterThan(start).count();
  }

  /// Get all commits
  Future<List<Commit>> getAll() {
    return _commits.where().sortByTimestampDesc().findAll();
  }

  /// Get recent commits (limited)
  Future<List<Commit>> getRecent({int limit = 10}) {
    return _commits.where().sortByTimestampDesc().limit(limit).findAll();
  }

  // ==========================================================================
  // Analytics & Insights
  // ==========================================================================

  /// Watch weekly activity for the last 8 weeks
  Stream<List<WeeklyActivity>> watchWeeklyActivity() {
    return _commits.watchLazy(fireImmediately: true).asyncMap((_) async {
      final now = DateTime.now();
      // Start of current week (Monday)
      final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
      final startOf8Weeks = currentWeekStart.subtract(
        const Duration(days: 7 * 7),
      );

      final startDate = DateTime(
        startOf8Weeks.year,
        startOf8Weeks.month,
        startOf8Weeks.day,
      );

      final commits = await _commits
          .filter()
          .timestampGreaterThan(startDate)
          .findAll();

      final weeks = <DateTime, int>{};

      // Initialize all 8 weeks with 0
      for (int i = 0; i < 8; i++) {
        final date = startOf8Weeks.add(Duration(days: i * 7));
        // Normalized date (start of day)
        final normalizedDate = DateTime(date.year, date.month, date.day);
        weeks[normalizedDate] = 0;
      }

      // Aggregate commits
      for (final commit in commits) {
        final date = commit.timestamp;
        // Find the Monday of this date's week
        final monday = date.subtract(Duration(days: date.weekday - 1));
        final normalizedMonday = DateTime(
          monday.year,
          monday.month,
          monday.day,
        );

        if (weeks.containsKey(normalizedMonday)) {
          weeks[normalizedMonday] = (weeks[normalizedMonday] ?? 0) + 1;
        }
      }

      final result = <WeeklyActivity>[];
      final sortedWeeks = weeks.keys.toList()..sort();

      for (final startOfWeek in sortedWeeks) {
        final endOfWeek = startOfWeek.add(const Duration(days: 6));

        String label;
        if (startOfWeek.month == endOfWeek.month) {
          label =
              '${startOfWeek.day}-${endOfWeek.day} ${_getMonthName(startOfWeek.month)}';
        } else {
          label =
              '${startOfWeek.day} ${_getMonthName(startOfWeek.month)} - ${endOfWeek.day} ${_getMonthName(endOfWeek.month)}';
        }

        result.add(
          WeeklyActivity(
            label: label,
            commits: weeks[startOfWeek] ?? 0,
            startOfWeek: startOfWeek,
          ),
        );
      }

      return result;
    });
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  /// Watch insight patterns (streaks, consistency, etc.)
  Stream<InsightPatterns> watchInsightPatterns() {
    return _commits.watchLazy(fireImmediately: true).asyncMap((_) async {
      final commits = await _commits.where().sortByTimestampDesc().findAll();

      if (commits.isEmpty) {
        return const InsightPatterns.empty();
      }

      // 1. Calculate Streaks
      // Get unique days with commits
      final uniqueDays = <int>{};
      for (final c in commits) {
        // Use day index since epoch
        final dayIndex = c.dayIndex;
        uniqueDays.add(dayIndex);
      }

      final sortedDays = uniqueDays.toList()
        ..sort((a, b) => b.compareTo(a)); // Descending

      if (sortedDays.isEmpty) {
        return const InsightPatterns.empty();
      }

      // Current Streak
      int currentStreak = 0;
      final todayIndex = DateTime.now().difference(DateTime(1970, 1, 1)).inDays;

      // Check if we have a commit today or yesterday
      int checkDay = todayIndex;
      if (!sortedDays.contains(checkDay)) {
        checkDay--; // Try yesterday
      }

      if (sortedDays.contains(checkDay)) {
        currentStreak = 1;
        int prevDay = checkDay;
        // Look for consecutive days before
        for (int i = 0; i < sortedDays.length; i++) {
          final day = sortedDays[i];
          if (day > checkDay) continue; // Should not happen given sort
          if (day == checkDay) continue; // Already counted

          if (day == prevDay - 1) {
            currentStreak++;
            prevDay = day;
          } else {
            if (day < prevDay - 1) break;
          }
        }
      } else {
        currentStreak = 0;
      }

      // Longest Streak
      int longestStreak = 0;
      int tempStreak = 0;
      int? lastDay;

      // Sort ascending for easier longest calculation
      final ascendingDays = sortedDays.reversed.toList();

      for (final day in ascendingDays) {
        if (lastDay == null) {
          tempStreak = 1;
        } else if (day == lastDay + 1) {
          tempStreak++;
        } else {
          // Gap
          if (tempStreak > longestStreak) longestStreak = tempStreak;
          tempStreak = 1;
        }
        lastDay = day;
      }
      if (tempStreak > longestStreak) longestStreak = tempStreak;

      // 2. Most Productive Day
      final dayCounts = <int, int>{}; // weekday 1-7 -> count
      for (final c in commits) {
        dayCounts[c.timestamp.weekday] =
            (dayCounts[c.timestamp.weekday] ?? 0) + 1;
      }

      var maxDayCount = 0;
      var bestDay = 1;

      dayCounts.forEach((day, count) {
        if (count > maxDayCount) {
          maxDayCount = count;
          bestDay = day;
        }
      });

      const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      final mostProductiveDay = maxDayCount > 0
          ? weekdays[bestDay - 1]
          : 'None';

      // 3. Consistency Score (Last 30 days)
      final now = DateTime.now();
      int activeDays30 = 0;
      for (int i = 0; i < 30; i++) {
        final date = now.subtract(Duration(days: i));
        final dayIndex = date.difference(DateTime(1970, 1, 1)).inDays;
        if (uniqueDays.contains(dayIndex)) {
          activeDays30++;
        }
      }
      final consistencyScore = ((activeDays30 / 30) * 100).round();

      return InsightPatterns(
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        mostProductiveDay: mostProductiveDay,
        consistencyScore: consistencyScore,
      );
    });
  }
}
