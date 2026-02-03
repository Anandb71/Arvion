import 'package:isar/isar.dart';
import '../models/protocol.dart';
import '../database/isar_database.dart';

/// Repository for Protocol operations
class ProtocolRepository {
  Isar get _isar => IsarDatabase.instance;
  IsarCollection<Protocol> get _protocols => _isar.protocols;

  /// Watch all active protocols
  Stream<List<Protocol>> watchActive() {
    return _protocols
        .filter()
        .isActiveEqualTo(true)
        .sortByCreatedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Watch all protocols
  Stream<List<Protocol>> watchAll() {
    return _protocols.where().sortByCreatedAtDesc().watch(fireImmediately: true);
  }

  /// Get all active protocols
  Future<List<Protocol>> getAllActive() {
    return _protocols
        .filter()
        .isActiveEqualTo(true)
        .sortByCreatedAtDesc()
        .findAll();
  }

  /// Get protocol by ID
  Future<Protocol?> getById(int id) {
    return _protocols.get(id);
  }

  /// Get protocols by task ID
  Future<List<Protocol>> getByTaskId(int taskId) {
    return _protocols
        .filter()
        .linkedTaskIdsElementEqualTo(taskId)
        .isActiveEqualTo(true)
        .findAll();
  }

  /// Search protocols by name
  Future<List<Protocol>> searchByName(String query) {
    return _protocols
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();
  }

  /// Create a new protocol
  Future<int> create(Protocol protocol) {
    return _isar.writeTxn(() => _protocols.put(protocol));
  }

  /// Update a protocol
  Future<int> update(Protocol protocol) {
    return _isar.writeTxn(() => _protocols.put(protocol));
  }

  /// Deactivate a protocol
  Future<void> deactivate(int id) async {
    await _isar.writeTxn(() async {
      final protocol = await _protocols.get(id);
      if (protocol != null) {
        protocol.isActive = false;
        await _protocols.put(protocol);
      }
    });
  }

  /// Activate a protocol
  Future<void> activate(int id) async {
    await _isar.writeTxn(() async {
      final protocol = await _protocols.get(id);
      if (protocol != null) {
        protocol.isActive = true;
        await _protocols.put(protocol);
      }
    });
  }

  /// Delete a protocol
  Future<bool> delete(int id) {
    return _isar.writeTxn(() => _protocols.delete(id));
  }

  /// Update protocol progress
  Future<void> updateProgress(int id, double progress) async {
    await _isar.writeTxn(() async {
      final protocol = await _protocols.get(id);
      if (protocol != null) {
        protocol.progressPercent = progress.clamp(0, 100);
        await _protocols.put(protocol);
      }
    });
  }

  /// Increment protocol commits
  Future<void> incrementCommits(int id) async {
    await _isar.writeTxn(() async {
      final protocol = await _protocols.get(id);
      if (protocol != null) {
        protocol.totalCommits++;
        await _protocols.put(protocol);
      }
    });
  }

  /// Record a successful week
  Future<void> recordSuccessfulWeek(int id) async {
    await _isar.writeTxn(() async {
      final protocol = await _protocols.get(id);
      if (protocol != null) {
        protocol.successfulWeeks++;
        await _protocols.put(protocol);
      }
    });
  }

  /// Record a failed week
  Future<void> recordFailedWeek(int id) async {
    await _isar.writeTxn(() async {
      final protocol = await _protocols.get(id);
      if (protocol != null) {
        protocol.failedWeeks++;
        await _protocols.put(protocol);
      }
    });
  }

  /// Get overdue protocols
  Future<List<Protocol>> getOverdue() {
    final now = DateTime.now();
    return _protocols
        .filter()
        .isActiveEqualTo(true)
        .deadlineLessThan(now)
        .findAll();
  }

  /// Get protocols expiring soon (within N days)
  Future<List<Protocol>> getExpiringSoon({int days = 7}) {
    final now = DateTime.now();
    final deadline = now.add(Duration(days: days));
    return _protocols
        .filter()
        .isActiveEqualTo(true)
        .deadlineBetween(now, deadline)
        .findAll();
  }
}
