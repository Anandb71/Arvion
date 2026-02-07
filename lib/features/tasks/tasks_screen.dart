import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../providers/providers.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';
import '../../data/models/task.dart';

/// Task management screen (Repositories view)
class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(filteredTasksProvider);
    final searchQuery = ref.watch(taskSearchQueryProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Tasks',
                style: ArvionTypography.headlineMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
              ),
              const Spacer(),
              GlowButton(
                label: 'New Task',
                icon: Icons.add,
                onPressed: () => _showTaskDialog(context, ref, null),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Your repositories for life tracking',
            style: ArvionTypography.bodyMedium.copyWith(
              color: ArvionColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: ArvionColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ArvionColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: ArvionColors.textMuted,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: (value) =>
                        ref.read(taskSearchQueryProvider.notifier).state =
                            value,
                    style: ArvionTypography.bodyMedium.copyWith(
                      color: ArvionColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search tasks...',
                      hintStyle: ArvionTypography.bodyMedium.copyWith(
                        color: ArvionColors.textMuted,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    color: ArvionColors.textMuted,
                    onPressed: () =>
                        ref.read(taskSearchQueryProvider.notifier).state = '',
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Task grid
          Expanded(
            child: tasksAsync.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return _buildEmptyState(context, ref);
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 350,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 200,
                  ),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => _TaskCard(
                    task: tasks[index],
                    onEdit: () => _showTaskDialog(context, ref, tasks[index]),
                    onDelete: () => _confirmDelete(context, ref, tasks[index]),
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: ArvionColors.primary),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Error: $e',
                  style: const TextStyle(color: ArvionColors.error),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ArvionColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.inbox_outlined,
              size: 40,
              color: ArvionColors.textMuted,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No tasks yet',
            style: ArvionTypography.titleMedium.copyWith(
              color: ArvionColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first task to start tracking',
            style: ArvionTypography.bodyMedium.copyWith(
              color: ArvionColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          GlowButton(
            label: 'Create Task',
            icon: Icons.add,
            onPressed: () => _showTaskDialog(context, ref, null),
          ),
        ],
      ),
    );
  }

  void _showTaskDialog(
    BuildContext context,
    WidgetRef ref,
    Task? existingTask,
  ) {
    showDialog(
      context: context,
      builder: (context) => _TaskDialog(
        existingTask: existingTask,
        onSave: (task) async {
          final repo = ref.read(taskRepositoryProvider);
          if (existingTask != null) {
            await repo.update(task);
          } else {
            await repo.create(task);
          }
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ArvionColors.surface,
        title: Text(
          'Delete "${task.title}"?',
          style: const TextStyle(color: ArvionColors.textPrimary),
        ),
        content: const Text(
          'This action cannot be undone.',
          style: TextStyle(color: ArvionColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(taskRepositoryProvider).delete(task.id);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: ArvionColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TaskCard({
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  Color get _color {
    final hex = task.colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onEdit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with color, title, and menu
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  task.title,
                  style: ArvionTypography.titleSmall.copyWith(
                    color: ArvionColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: ArvionColors.textMuted,
                  size: 18,
                ),
                color: ArvionColors.surface,
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text(
                      'Edit',
                      style: TextStyle(color: ArvionColors.textPrimary),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: TextStyle(color: ArvionColors.error),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (task.description != null) ...[
            const SizedBox(height: 8),
            Text(
              task.description!,
              style: ArvionTypography.bodySmall.copyWith(
                color: ArvionColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          // Verification type badge
          if (task.verificationType != VerificationType.manual) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ArvionColors.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                task.verificationType == VerificationType.appUsage
                    ? '🖥 Auto-Track'
                    : task.verificationType.name,
                style: ArvionTypography.labelSmall.copyWith(
                  color: ArvionColors.secondary,
                ),
              ),
            ),
          ],
          const Spacer(),
          // Stats
          Row(
            children: [
              _StatChip(
                icon: Icons.commit,
                value: task.totalCommits.toString(),
                label: 'commits',
              ),
              const SizedBox(width: 12),
              _StatChip(
                icon: Icons.local_fire_department,
                value: task.currentStreak.toString(),
                label: 'streak',
                color: task.currentStreak > 0 ? ArvionColors.warning : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color ?? ArvionColors.textMuted),
        const SizedBox(width: 4),
        Text(
          value,
          style: ArvionTypography.monoSmall.copyWith(
            color: color ?? ArvionColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _TaskDialog extends StatefulWidget {
  final Task? existingTask;
  final Function(Task) onSave;

  const _TaskDialog({this.existingTask, required this.onSave});

  @override
  State<_TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<_TaskDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _appNameController = TextEditingController();
  final _durationController = TextEditingController(text: '60');
  String _selectedColor = '#00D26A';
  int _difficulty = 2;
  VerificationType _verificationType = VerificationType.manual;

  final _colors = [
    '#00D26A',
    '#0969DA',
    '#8957E5',
    '#F78166',
    '#D29922',
    '#F85149',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      final t = widget.existingTask!;
      _titleController.text = t.title;
      _descController.text = t.description ?? '';
      _selectedColor = t.colorHex;
      _difficulty = t.difficulty;
      _verificationType = t.verificationType;
      if (t.verificationConfig != null) {
        try {
          final config = jsonDecode(t.verificationConfig!);
          _appNameController.text = config['app_name'] ?? '';
          _durationController.text = (config['duration_minutes'] ?? 60)
              .toString();
        } catch (_) {}
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _appNameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingTask != null;
    return Dialog(
      backgroundColor: ArvionColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ArvionColors.border),
      ),
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEdit ? 'Edit Task' : 'Create Task',
                style: ArvionTypography.titleLarge.copyWith(
                  color: ArvionColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              // Title
              TextField(
                controller: _titleController,
                style: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'Task title',
                  hintText: 'e.g., Learn German',
                ),
              ),
              const SizedBox(height: 16),
              // Description
              TextField(
                controller: _descController,
                style: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                ),
              ),
              const SizedBox(height: 20),
              // Color picker
              Text(
                'Color',
                style: ArvionTypography.labelMedium.copyWith(
                  color: ArvionColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: _colors.map((color) {
                  final isSelected = color == _selectedColor;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse('FF${color.substring(1)}', radix: 16),
                        ),
                        borderRadius: BorderRadius.circular(6),
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 2)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Difficulty
              Text(
                'Difficulty',
                style: ArvionTypography.labelMedium.copyWith(
                  color: ArvionColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  final level = index + 1;
                  final isSelected = level == _difficulty;
                  return GestureDetector(
                    onTap: () => setState(() => _difficulty = level),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ArvionColors.primary
                            : ArvionColors.surfaceLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          level.toString(),
                          style: ArvionTypography.monoSmall.copyWith(
                            color: isSelected
                                ? ArvionColors.background
                                : ArvionColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Verification Type
              Text(
                'Verification',
                style: ArvionTypography.labelMedium.copyWith(
                  color: ArvionColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<VerificationType>(
                value: _verificationType,
                dropdownColor: ArvionColors.surface,
                style: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
                decoration: const InputDecoration(isDense: true),
                onChanged: (v) => setState(() => _verificationType = v!),
                items: const [
                  DropdownMenuItem(
                    value: VerificationType.manual,
                    child: Text('Manual'),
                  ),
                  DropdownMenuItem(
                    value: VerificationType.appUsage,
                    child: Text('App Usage (Auto-Track)'),
                  ),
                ],
              ),
              // App usage config
              if (_verificationType == VerificationType.appUsage) ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _appNameController,
                  style: ArvionTypography.bodyMedium.copyWith(
                    color: ArvionColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'App Name (in window title)',
                    hintText: 'e.g., VS Code, Chrome',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  style: ArvionTypography.bodyMedium.copyWith(
                    color: ArvionColors.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Duration (minutes)',
                    hintText: 'e.g., 60',
                  ),
                ),
              ],
              const SizedBox(height: 32),
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  GlowButton(
                    label: isEdit ? 'Save' : 'Create',
                    onPressed: () {
                      if (_titleController.text.isEmpty) return;
                      final task = widget.existingTask ?? Task();
                      task.title = _titleController.text;
                      task.colorHex = _selectedColor;
                      task.difficulty = _difficulty;
                      task.description = _descController.text.isEmpty
                          ? null
                          : _descController.text;
                      task.verificationType = _verificationType;
                      if (_verificationType == VerificationType.appUsage) {
                        task.verificationConfig = jsonEncode({
                          'app_name': _appNameController.text,
                          'duration_minutes':
                              int.tryParse(_durationController.text) ?? 60,
                        });
                      } else {
                        task.verificationConfig = null;
                      }
                      if (widget.existingTask == null)
                        task.createdAt = DateTime.now();
                      widget.onSave(task);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
