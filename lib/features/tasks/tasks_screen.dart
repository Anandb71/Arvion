import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                onPressed: () => _showCreateTaskDialog(context, ref),
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
                const Icon(Icons.search, color: ArvionColors.textMuted, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    onChanged: (value) =>
                        ref.read(taskSearchQueryProvider.notifier).state = value,
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
                    mainAxisExtent: 180,
                  ),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => _TaskCard(task: tasks[index]),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: ArvionColors.primary),
              ),
              error: (e, _) => Center(
                child: Text('Error: $e', style: const TextStyle(color: ArvionColors.error)),
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
            onPressed: () => _showCreateTaskDialog(context, ref),
          ),
        ],
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => _CreateTaskDialog(
        onSave: (task) async {
          final repo = ref.read(taskRepositoryProvider);
          await repo.create(task);
        },
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;

  const _TaskCard({required this.task});

  Color get _color {
    final hex = task.colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () {
        // TODO: Open task details
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with color and icon
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
              if (task.icon != null)
                Text(task.icon!, style: const TextStyle(fontSize: 16)),
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
          const SizedBox(height: 12),
          // Tags
          if (task.tags.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: task.tags.take(3).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: ArvionColors.surfaceLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: ArvionTypography.labelSmall.copyWith(
                      color: ArvionColors.textMuted,
                    ),
                  ),
                );
              }).toList(),
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

class _CreateTaskDialog extends StatefulWidget {
  final Function(Task) onSave;

  const _CreateTaskDialog({required this.onSave});

  @override
  State<_CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<_CreateTaskDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedColor = '#00D26A';
  int _difficulty = 2;

  final _colors = [
    '#00D26A', // Green
    '#0969DA', // Blue
    '#8957E5', // Purple
    '#F78166', // Orange
    '#D29922', // Yellow
    '#F85149', // Red
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ArvionColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ArvionColors.border),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Task',
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
                      color: Color(int.parse('FF${color.substring(1)}', radix: 16)),
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
                      color:
                          isSelected ? ArvionColors.primary : ArvionColors.surfaceLight,
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
                  label: 'Create',
                  onPressed: () {
                    if (_titleController.text.isEmpty) return;
                    final task = Task.create(
                      title: _titleController.text,
                      colorHex: _selectedColor,
                      difficulty: _difficulty,
                      description: _descController.text.isEmpty
                          ? null
                          : _descController.text,
                    );
                    widget.onSave(task);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
