import 'package:isar/isar.dart';
import '../models/protocol.dart';
import '../database/isar_database.dart';

/// Repository for Protocol operations
class ProtocolRepository {
  Isar get _isar => IsarDatabase.instance;

  /// Get all active protocols
  Future<List<Protocol>> getAllActive() async {
    return _isar.protocols.filter().isActiveEqualTo(true).findAll();
  }

  /// Get all protocols (active and inactive)
  Future<List<Protocol>> getAll() async {
    return _isar.protocols.where().findAll();
  }

  /// Watch all active protocols
  Stream<List<Protocol>> watchAllActive() {
    return _isar.protocols
        .filter()
        .isActiveEqualTo(true)
        .watch(fireImmediately: true);
  }

  /// Add or update a protocol
  Future<int> save(Protocol protocol) async {
    return _isar.writeTxn(() => _isar.protocols.put(protocol));
  }

  /// Delete a protocol (soft delete usually, but here physical delete for MVP)
  Future<bool> delete(int id) async {
    return _isar.writeTxn(() => _isar.protocols.delete(id));
  }

  /// Toggle completion (update stats)
  Future<void> complete(int id) async {
    await _isar.writeTxn(() async {
      final protocol = await _isar.protocols.get(id);
      if (protocol != null) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        // specific logic for completion could be added here
        // For MVP, we just mark updated time and increment completions

        // Handle streak logic (simplified)
        if (protocol.lastCompletedAt != null) {
          final last = protocol.lastCompletedAt!;
          final diff = today
              .difference(DateTime(last.year, last.month, last.day))
              .inDays;

          if (diff == 1) {
            protocol.currentStreak++;
          } else if (diff > 1) {
            // Streak broken
            protocol.currentStreak = 1;
          } else {
            // Already completed today
            return;
          }
        } else {
          protocol.currentStreak = 1;
        }

        if (protocol.currentStreak > protocol.longestStreak) {
          protocol.longestStreak = protocol.currentStreak;
        }

        protocol.totalCompletions++;
        protocol.lastCompletedAt = now;

        await _isar.protocols.put(protocol);
      }
    });
  }
}
