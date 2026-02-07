import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';
import '../data/repositories/task_repository.dart';
import '../data/repositories/commit_repository.dart';
import '../data/models/commit.dart';
import '../data/models/task.dart';

/// Service to verify task completion automatically
class VerificationService {
  final TaskRepository taskRepository;
  final CommitRepository commitRepository;
  Timer? _timer;

  // Track accumulated minutes for each task: taskId -> minutes
  final Map<int, int> _accumulatedMinutes = {};

  // Track last commit time for each task to prevent multiple commits per day (optional)
  // or per session. For now, we'll allow multiple but maybe rate limit.

  VerificationService({
    required this.taskRepository,
    required this.commitRepository,
  });

  /// Start monitoring
  void start() {
    _timer?.cancel();
    // Check every 60 seconds
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _checkActiveWindow();
    });
  }

  /// Stop monitoring
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// Check current active window and update task progress
  Future<void> _checkActiveWindow() async {
    try {
      // Get active window title using Win32 API
      final hwnd = GetForegroundWindow();
      if (hwnd == 0) return;

      final length = GetWindowTextLength(hwnd);
      if (length == 0) return;

      final buffer = wsalloc(length + 1);
      GetWindowText(hwnd, buffer, length + 1);
      final windowTitle = buffer.toDartString();
      free(buffer);

      if (windowTitle.isEmpty) return;

      // Note: We could also get process name for more robustness,
      // but title is often enough for "VS Code" etc.

      // Get all tasks with app_usage verification
      final tasks = await taskRepository.getAllActive();
      final usageTasks = tasks
          .where((t) => t.verificationType == VerificationType.appUsage)
          .toList();

      for (final task in usageTasks) {
        if (task.verificationConfig == null) continue;

        try {
          final config = jsonDecode(task.verificationConfig!);
          final targetApp = config['app_name'] as String?;
          final targetDuration = config['duration_minutes'] as int? ?? 60;

          if (targetApp != null &&
              windowTitle.toLowerCase().contains(targetApp.toLowerCase())) {
            // Match found! Increment counter
            _accumulatedMinutes[task.id] =
                (_accumulatedMinutes[task.id] ?? 0) + 1;

            // Allow checking progress in UI if we were to expose it
            // print('Task ${task.title}: ${_accumulatedMinutes[task.id]}/$targetDuration mins');

            if (_accumulatedMinutes[task.id]! >= targetDuration) {
              await _commitTask(task);
              // Reset counter after commit? Or keep it?
              // Usually for "Code 1hr", we want one commit.
              // Let's reset to allow another commit if they code ANOTHER hour.
              _accumulatedMinutes[task.id] = 0;
            }
          }
        } catch (e) {
          // Ignore invalid config
        }
      }
    } catch (e) {
      // print('Error verifying app usage: $e');
    }
  }

  Future<void> _commitTask(Task task) async {
    final commit = Commit.create(
      taskIds: [task.id],
      intensity: 3,
      source: CommitSource.appUsage,
      note: 'Auto-verified via App Usage',
      confidence: 1.0,
    );

    await commitRepository.create(commit);
    // Update task stats
    await taskRepository.incrementCommits(task.id);
    await taskRepository.updateStreak(task.id, task.currentStreak + 1);
  }
}
