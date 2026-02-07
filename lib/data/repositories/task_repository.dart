import 'package:isar/isar.dart';
import '../models/task.dart';
import '../database/isar_database.dart';

/// Repository for Task operations
class TaskRepository {
  Isar get _isar => IsarDatabase.instance;
  IsarCollection<Task> get _tasks => _isar.tasks;

  /// Watch all active tasks as a stream
  Stream<List<Task>> watchAllActive() {
    return _tasks
        .filter()
        .isArchivedEqualTo(false)
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Watch all tasks including archived
  Stream<List<Task>> watchAll() {
    return _tasks.where().sortByCreatedAtDesc().watch(fireImmediately: true);
  }

  /// Get all active tasks
  Future<List<Task>> getAllActive() {
    return _tasks
        .filter()
        .isArchivedEqualTo(false)
        .sortByCreatedAtDesc()
        .findAll();
  }

  /// Get all tasks (including archived) for lookups
  Future<List<Task>> getAll() {
    return _tasks.where().findAll();
  }

  /// Get task by ID
  Future<Task?> getById(int id) {
    return _tasks.get(id);
  }

  /// Get tasks by IDs
  Future<List<Task>> getByIds(List<int> ids) async {
    final tasks = await _tasks.getAll(ids);
    return tasks.whereType<Task>().toList();
  }

  /// Search tasks by title
  Future<List<Task>> searchByTitle(String query) {
    return _tasks
        .filter()
        .titleContains(query, caseSensitive: false)
        .isArchivedEqualTo(false)
        .findAll();
  }

  /// Get tasks by tag
  Future<List<Task>> getByTag(String tag) {
    return _tasks
        .filter()
        .tagsElementContains(tag)
        .isArchivedEqualTo(false)
        .findAll();
  }

  /// Create a new task
  Future<int> create(Task task) {
    return _isar.writeTxn(() => _tasks.put(task));
  }

  /// Update a task
  Future<int> update(Task task) {
    return _isar.writeTxn(() => _tasks.put(task));
  }

  /// Archive a task
  Future<void> archive(int id) async {
    await _isar.writeTxn(() async {
      final task = await _tasks.get(id);
      if (task != null) {
        task.isArchived = true;
        await _tasks.put(task);
      }
    });
  }

  /// Unarchive a task
  Future<void> unarchive(int id) async {
    await _isar.writeTxn(() async {
      final task = await _tasks.get(id);
      if (task != null) {
        task.isArchived = false;
        await _tasks.put(task);
      }
    });
  }

  /// Delete a task permanently
  Future<bool> delete(int id) {
    return _isar.writeTxn(() => _tasks.delete(id));
  }

  /// Update task streak
  Future<void> updateStreak(int taskId, int newStreak) async {
    await _isar.writeTxn(() async {
      final task = await _tasks.get(taskId);
      if (task != null) {
        task.currentStreak = newStreak;
        if (newStreak > task.longestStreak) {
          task.longestStreak = newStreak;
        }
        await _tasks.put(task);
      }
    });
  }

  /// Increment total commits for a task
  Future<void> incrementCommits(int taskId) async {
    await _isar.writeTxn(() async {
      final task = await _tasks.get(taskId);
      if (task != null) {
        task.totalCommits++;
        task.lastActivityAt = DateTime.now();
        await _tasks.put(task);
      }
    });
  }
}
