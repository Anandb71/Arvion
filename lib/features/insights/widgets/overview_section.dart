import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../providers/providers.dart';

/// Overview section showing key stats
class OverviewSection extends ConsumerWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCommits = ref.watch(totalCommitCountProvider);
    final todayCommits = ref.watch(todayCommitCountProvider);
    final weekCommits = ref.watch(weekCommitCountProvider);
    final activeTasks = ref.watch(activeTasksProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _StatCard(
              title: 'Total Commits',
              value: totalCommits.when(
                data: (v) => v.toString(),
                loading: () => '...',
                error: (_, __) => '0',
              ),
              subtitle: 'All time',
              icon: Icons.commit,
              color: ArvionColors.primary,
              width: isNarrow ? double.infinity : 180,
            ),
            _StatCard(
              title: 'Today',
              value: todayCommits.when(
                data: (v) => v.toString(),
                loading: () => '...',
                error: (_, __) => '0',
              ),
              subtitle: 'commits',
              icon: Icons.today,
              color: ArvionColors.success,
              width: isNarrow ? double.infinity : 180,
            ),
            _StatCard(
              title: 'This Week',
              value: weekCommits.when(
                data: (v) => v.toString(),
                loading: () => '...',
                error: (_, __) => '0',
              ),
              subtitle: 'commits',
              icon: Icons.date_range,
              color: ArvionColors.info,
              width: isNarrow ? double.infinity : 180,
            ),
            _StatCard(
              title: 'Active Tasks',
              value: activeTasks.when(
                data: (v) => v.length.toString(),
                loading: () => '...',
                error: (_, __) => '0',
              ),
              subtitle: 'tracking',
              icon: Icons.task_alt,
              color: ArvionColors.secondary,
              width: isNarrow ? double.infinity : 180,
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double width;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ArvionColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ArvionColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Text(
                subtitle,
                style: ArvionTypography.labelSmall.copyWith(
                  color: ArvionColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: ArvionTypography.headlineLarge.copyWith(
              color: ArvionColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: ArvionTypography.bodySmall.copyWith(
              color: ArvionColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
