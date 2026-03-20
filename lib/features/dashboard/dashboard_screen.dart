import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../data/models/models.dart';
import '../../core/utils/color_utils.dart';
import '../../providers/providers.dart';
import 'widgets/heatmap_grid.dart';
import 'widgets/stats_card.dart';
import 'widgets/daily_summary_panel.dart';
import 'widgets/screen_time_card.dart';

/// Main dashboard screen with heatmap and summary - fully responsive
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive breakpoints
        final isNarrow = constraints.maxWidth < 900;
        final isVeryNarrow = constraints.maxWidth < 600;

        return SingleChildScrollView(
          padding: EdgeInsets.all(isVeryNarrow ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: isVeryNarrow ? 20 : 32),
              _buildStatsCards(ref, isVeryNarrow),
              SizedBox(height: isVeryNarrow ? 20 : 32),
              if (isNarrow)
                _buildNarrowLayout(context, ref)
              else
                _buildWideLayout(context, ref),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getGreeting(),
          style: ArvionTypography.headlineMedium.copyWith(
            color: ArvionColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Track your progress, commit to your goals.',
          style: ArvionTypography.bodyMedium.copyWith(
            color: ArvionColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards(WidgetRef ref, bool isCompact) {
    final todayCountAsync = ref.watch(todayCommitCountProvider);
    final weekCommitsAsync = ref.watch(weekCommitCountProvider);
    final totalCommitsAsync = ref.watch(totalCommitCountProvider);
    final activeTasksAsync = ref.watch(activeTasksProvider);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: isCompact ? double.infinity : 200,
          child: todayCountAsync.when(
            data: (count) => StatsCard(
              title: 'Today',
              value: count.toString(),
              subtitle: 'commits',
              icon: Icons.today,
              accentColor: ArvionColors.primary,
            ),
            loading: () => const _LoadingCard(),
            error: (_, __) => const _LoadingCard(),
          ),
        ),
        SizedBox(
          width: isCompact ? double.infinity : 200,
          child: weekCommitsAsync.when(
            data: (count) => StatsCard(
              title: 'This Week',
              value: count.toString(),
              subtitle: 'commits',
              icon: Icons.calendar_view_week,
              accentColor: ArvionColors.secondary,
            ),
            loading: () => const _LoadingCard(),
            error: (_, __) => const _LoadingCard(),
          ),
        ),
        SizedBox(
          width: isCompact ? double.infinity : 200,
          child: totalCommitsAsync.when(
            data: (count) => StatsCard(
              title: 'Total',
              value: count.toString(),
              subtitle: 'all time',
              icon: Icons.insights,
              accentColor: ArvionColors.info,
            ),
            loading: () => const _LoadingCard(),
            error: (_, __) => const _LoadingCard(),
          ),
        ),
        SizedBox(
          width: isCompact ? double.infinity : 200,
          child: activeTasksAsync.when(
            data: (tasks) => StatsCard(
              title: 'Active Tasks',
              value: tasks.length.toString(),
              subtitle: 'tracking',
              icon: Icons.task_alt,
              accentColor: ArvionColors.success,
            ),
            loading: () => const _LoadingCard(),
            error: (_, __) => const _LoadingCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildWideLayout(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildHeatmapSection(context, ref)),
            const SizedBox(width: 24),
            SizedBox(width: 300, child: _buildDailySummary(context, ref)),
          ],
        ),
        const SizedBox(height: 24),
        const ScreenTimeCard(), // New screen time widget
        const SizedBox(height: 24),
        _buildPerTaskHeatmaps(ref),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildDailySummary(context, ref),
        const SizedBox(height: 24),
        const ScreenTimeCard(), // New screen time widget
        const SizedBox(height: 24),
        _buildHeatmapSection(context, ref),
        const SizedBox(height: 24),
        _buildPerTaskHeatmaps(ref),
      ],
    );
  }

  Widget _buildHeatmapSection(BuildContext context, WidgetRef ref) {
    final heatmapAsync = ref.watch(heatmapDataProvider);
    final simpleHeatmapAsync = ref.watch(simpleHeatmapProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Contribution Graph',
                style: ArvionTypography.titleMedium.copyWith(
                  color: ArvionColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const HeatmapLegend(),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ArvionColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ArvionColors.border),
          ),
          child: heatmapAsync.when(
            data: (multiData) => HeatmapGrid(
              multiColorData: multiData,
              weeks: 52,
              onCellTap: (date) => _showDayDetails(context, date),
            ),
            loading: () => simpleHeatmapAsync.when(
              data: (data) => HeatmapGrid(
                data: data,
                weeks: 52,
                onCellTap: (date) => _showDayDetails(context, date),
              ),
              loading: () => const SizedBox(
                height: 120,
                child: Center(
                  child: CircularProgressIndicator(color: ArvionColors.primary),
                ),
              ),
              error: (e, _) => Text('Error: $e'),
            ),
            error: (e, _) => simpleHeatmapAsync.when(
              data: (data) => HeatmapGrid(
                data: data,
                weeks: 52,
                onCellTap: (date) => _showDayDetails(context, date),
              ),
              loading: () => const SizedBox(height: 120),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPerTaskHeatmaps(WidgetRef ref) {
    final perTaskAsync = ref.watch(perTaskHeatmapsProvider);

    return perTaskAsync.when(
      data: (taskHeatmaps) {
        if (taskHeatmaps.isEmpty) {
          return const SizedBox.shrink();
        }
        return _ExpandableTaskGraphs(
          taskHeatmaps: taskHeatmaps.values.toList(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildDailySummary(BuildContext context, WidgetRef ref) {
    final todayCountAsync = ref.watch(todayCommitCountProvider);
    final activeTasksAsync = ref.watch(activeTasksProvider);

    return todayCountAsync.when(
      data: (count) => DailySummaryPanel(
        todayCommits: count,
        todayGoal: 5,
        tasks: activeTasksAsync.when(
          data: (tasks) => tasks
              .take(3)
              .map(
                (t) => DailyTask(
                  title: t.title,
                  colorHex: t.colorHex,
                  todayCount: 0,
                  streak: t.currentStreak,
                ),
              )
              .toList(),
          loading: () => [],
          error: (_, __) => [],
        ),
        onQuickCommit: () => _showQuickCommitDialog(context, ref),
      ),
      loading: () => const _LoadingCard(),
      error: (_, __) => const _LoadingCard(),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  void _showDayDetails(BuildContext context, DateTime date) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing commits for ${date.toString().split(' ')[0]}'),
        backgroundColor: ArvionColors.surface,
      ),
    );
  }

  void _showQuickCommitDialog(BuildContext context, WidgetRef ref) {
    final activeTasksAsync = ref.read(activeTasksProvider);

    showDialog(
      context: context,
      builder: (dialogContext) => _QuickCommitDialog(
        tasks: activeTasksAsync.when(
          data: (tasks) => tasks,
          loading: () => [],
          error: (_, __) => [],
        ),
        onCommit: (taskIds, intensity, note) async {
          final commitRepo = ref.read(commitRepositoryProvider);
          final commit = Commit.create(
            intensity: intensity,
            taskIds: taskIds,
            note: note,
          );
          await commitRepo.create(commit);

          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('✓ Commit logged! +$intensity intensity'),
                backgroundColor: ArvionColors.primary,
              ),
            );
          }
        },
      ),
    );
  }
}

class _QuickCommitDialog extends StatefulWidget {
  final List<Task> tasks;
  final Function(List<int>, int, String?) onCommit;

  const _QuickCommitDialog({required this.tasks, required this.onCommit});

  @override
  State<_QuickCommitDialog> createState() => _QuickCommitDialogState();
}

class _QuickCommitDialogState extends State<_QuickCommitDialog> {
  final Set<int> _selectedTaskIds = {};
  int _intensity = 3;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
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
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Commit',
                style: ArvionTypography.titleLarge.copyWith(
                  color: ArvionColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Log your progress',
                style: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Intensity selector
              Text(
                'Intensity',
                style: ArvionTypography.labelMedium.copyWith(
                  color: ArvionColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  final level = index + 1;
                  final isSelected = level == _intensity;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _intensity = level),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 44,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ArvionColors.heatmapGreen[level]
                              : ArvionColors.surfaceLight,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            level.toString(),
                            style: ArvionTypography.monoSmall.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : ArvionColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Task selector (optional)
              if (widget.tasks.isNotEmpty) ...[
                Text(
                  'Link to Tasks (optional)',
                  style: ArvionTypography.labelMedium.copyWith(
                    color: ArvionColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.tasks.map((task) {
                    final isSelected = _selectedTaskIds.contains(task.id);
                    return GestureDetector(
                      onTap: () => setState(() {
                        if (isSelected) {
                          _selectedTaskIds.remove(task.id);
                        } else {
                          _selectedTaskIds.add(task.id);
                        }
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorUtils.hexToColor(
                                  task.colorHex,
                                ).withOpacity(0.2)
                              : ArvionColors.surfaceLight,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isSelected
                                ? ColorUtils.hexToColor(task.colorHex)
                                : ArvionColors.border,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: ColorUtils.hexToColor(task.colorHex),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              task.title,
                              style: ArvionTypography.bodySmall.copyWith(
                                color: isSelected
                                    ? ArvionColors.textPrimary
                                    : ArvionColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],

              // Note (optional)
              TextField(
                controller: _noteController,
                style: ArvionTypography.bodyMedium.copyWith(
                  color: ArvionColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                  hintText: 'What did you work on?',
                ),
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
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Commit'),
                    onPressed: () => widget.onCommit(
                      _selectedTaskIds.toList(),
                      _intensity,
                      _noteController.text.isEmpty
                          ? null
                          : _noteController.text,
                    ),
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

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ArvionColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ArvionColors.border),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: ArvionColors.primary,
        ),
      ),
    );
  }
}

class _ExpandableTaskGraphs extends StatefulWidget {
  final List<TaskHeatmapData> taskHeatmaps;

  const _ExpandableTaskGraphs({required this.taskHeatmaps});

  @override
  State<_ExpandableTaskGraphs> createState() => _ExpandableTaskGraphsState();
}

class _ExpandableTaskGraphsState extends State<_ExpandableTaskGraphs> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with expand/collapse button
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: ArvionColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ArvionColors.border),
            ),
            child: Row(
              children: [
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: ArvionColors.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _isExpanded ? 'Hide Task Graphs' : 'View All Task Graphs',
                  style: ArvionTypography.titleSmall.copyWith(
                    color: ArvionColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: ArvionColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${widget.taskHeatmaps.length} tasks',
                    style: ArvionTypography.monoXSmall.copyWith(
                      color: ArvionColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expandable content
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: widget.taskHeatmaps
                  .map(
                    (taskData) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TaskHeatmapGrid(taskData: taskData),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
