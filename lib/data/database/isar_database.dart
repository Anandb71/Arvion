import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';
import '../models/commit.dart';
import '../models/protocol.dart';
import '../models/screen_time_log.dart';

/// Isar Database Manager
/// Handles database initialization and provides access to collections
class IsarDatabase {
  static Isar? _instance;

  IsarDatabase._();

  /// Get the Isar database instance
  static Isar get instance {
    if (_instance == null) {
      throw StateError(
        'Database not initialized. Call IsarDatabase.initialize() first.',
      );
    }
    return _instance!;
  }

  /// Check if database is initialized
  static bool get isInitialized => _instance != null;

  /// Initialize the Isar database
  static Future<Isar> initialize() async {
    if (_instance != null) return _instance!;

    final dir = await getApplicationDocumentsDirectory();
    
    _instance = await Isar.open(
      [TaskSchema, CommitSchema, ProtocolSchema, ScreenTimeLogSchema],
      directory: dir.path,
      name: 'arvion_db',
      inspector: true, // Enable Isar Inspector for debugging
    );

    return _instance!;
  }

  /// Close the database
  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }

  /// Clear all data (for testing/reset)
  static Future<void> clearAll() async {
    final isar = instance;
    await isar.writeTxn(() async {
      await isar.tasks.clear();
      await isar.commits.clear();
      await isar.protocols.clear();
      await isar.screenTimeLogs.clear();
    });
  }
}
