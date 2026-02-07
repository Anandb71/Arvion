import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/glow_button.dart';

/// Daily summary panel showing today's progress
class DailySummaryPanel extends StatelessWidget {
  final int todayCommits;
  final int todayGoal;
  final List<DailyTask> tasks;
  final VoidCallback? onQuickCommit;
  final VoidCallback? onViewAll;

  const DailySummaryPanel({
    super.key,
    required this.todayCommits,
    this.todayGoal = 5,
    this.tasks = const [],
    this.onQuickCommit,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (todayCommits / todayGoal).clamp(0.0, 1.0);

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                'Today',
                style: ArvionTypography.titleMedium.copyWith(
                  color: ArvionColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                _getDateString(),
                style: ArvionTypography.bodySmall.copyWith(
                  color: ArvionColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress indicator
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$todayCommits',
                          style: ArvionTypography.monoLarge.copyWith(
                            color: ArvionColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' / $todayGoal commits',
                          style: ArvionTypography.bodyMedium.copyWith(
                            color: ArvionColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildProgressBar(progress),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _buildProgressCircle(progress),
            ],
          ),
          const SizedBox(height: 20),

          // Quick actions
          SizedBox(
            width: double.infinity,
            child: GlowButton(
              label: 'Quick Commit',
              icon: Icons.add,
              onPressed: onQuickCommit,
            ),
          ),
          const SizedBox(height: 20),

          // Task list
          if (tasks.isNotEmpty) ...[
            Row(
              children: [
                Text(
                  'Active Tasks',
                  style: ArvionTypography.titleSmall.copyWith(
                    color: ArvionColors.textSecondary,
                  ),
                ),
                const Spacer(),
                if (onViewAll != null)
                  GestureDetector(
                    onTap: onViewAll,
                    child: Text(
                      'View all',
                      style: ArvionTypography.bodySmall.copyWith(
                        color: ArvionColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            ...tasks.take(3).map((task) => _buildTaskItem(task)),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: ArvionColors.surfaceLight,
        borderRadius: BorderRadius.circular(3),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0E4429), ArvionColors.primary],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCircle(double progress) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 4,
              backgroundColor: ArvionColors.surfaceLight,
              valueColor: const AlwaysStoppedAnimation(ArvionColors.primary),
            ),
          ),
          Text(
            '${(progress * 100).round()}%',
            style: ArvionTypography.monoSmall.copyWith(
              color: ArvionColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(DailyTask task) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _hexToColor(task.colorHex),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              task.title,
              style: ArvionTypography.bodyMedium.copyWith(
                color: ArvionColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: ArvionColors.surfaceLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${task.todayCount} today',
              style: ArvionTypography.monoXSmall.copyWith(
                color: ArvionColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDateString() {
    final now = DateTime.now();
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = [
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
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}

class DailyTask {
  final String title;
  final String colorHex;
  final int todayCount;

  const DailyTask({
    required this.title,
    required this.colorHex,
    this.todayCount = 0,
  });
}
