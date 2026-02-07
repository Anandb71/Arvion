import 'package:isar/isar.dart';
import '../models/screen_time_log.dart';
import '../database/isar_database.dart';

/// Repository for Screen Time operations
class ScreenTimeRepository {
  Isar get _isar => IsarDatabase.instance;
  IsarCollection<ScreenTimeLog> get _logs => _isar.screenTimeLogs;

  /// Log a screen time activity
  Future<int> logActivity({
    required String appName,
    required String windowTitle,
    required int durationSeconds,
    bool isActive = true,
  }) {
    final log = ScreenTimeLog.create(
      appName: appName,
      windowTitle: windowTitle,
      durationSeconds: durationSeconds,
      isActive: isActive,
    );
    return _isar.writeTxn(() => _logs.put(log));
  }

  /// Get total screen time for a specific date (in seconds)
  Future<int> getDailyTotal(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final logs = await _logs
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .findAll();

    return logs.fold<int>(0, (sum, log) => sum + log.durationSeconds);
  }

  /// Get total active time for a specific date (in seconds)
  Future<int> getDailyActiveTime(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final logs = await _logs
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .isActiveEqualTo(true)
        .findAll();

    return logs.fold<int>(0, (sum, log) => sum + log.durationSeconds);
  }

  /// Get top apps for a specific date
  Future<List<AppUsage>> getTopApps(DateTime date, {int limit = 10}) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final logs = await _logs
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .findAll();

    // Group by app name
    final appTotals = <String, int>{};
    for (final log in logs) {
      appTotals[log.appName] =
          (appTotals[log.appName] ?? 0) + log.durationSeconds;
    }

    // Convert to list and sort
    final usage =
        appTotals.entries
            .map((e) => AppUsage(appName: e.key, totalSeconds: e.value))
            .toList()
          ..sort((a, b) => b.totalSeconds.compareTo(a.totalSeconds));

    return usage.take(limit).toList();
  }

  /// Get hourly breakdown for a specific date
  Future<Map<int, int>> getHourlyBreakdown(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final logs = await _logs
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .findAll();

    final hourlyData = <int, int>{};
    for (int i = 0; i < 24; i++) {
      hourlyData[i] = 0;
    }

    for (final log in logs) {
      final hour = log.hourOfDay;
      hourlyData[hour] = (hourlyData[hour] ?? 0) + log.durationSeconds;
    }

    return hourlyData;
  }

  /// Watch daily total as a stream (for real-time updates)
  Stream<int> watchDailyTotal(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _logs
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .watch(fireImmediately: true)
        .map(
          (logs) => logs.fold<int>(0, (sum, log) => sum + log.durationSeconds),
        );
  }

  /// Get all logs for a date range (for debugging)
  Future<List<ScreenTimeLog>> getByDateRange(DateTime start, DateTime end) {
    return _logs
        .filter()
        .timestampBetween(start, end)
        .sortByTimestampDesc()
        .findAll();
  }

  /// Clear old logs (e.g., older than 90 days)
  Future<void> clearOldLogs({int daysToKeep = 90}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));

    await _isar.writeTxn(() async {
      await _logs.filter().timestampLessThan(cutoffDate).deleteAll();
    });
  }
}

/// Helper class for app usage data
class AppUsage {
  final String appName;
  final int totalSeconds;

  AppUsage({required this.appName, required this.totalSeconds});

  String get formattedDuration {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}
