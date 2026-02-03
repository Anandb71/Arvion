import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../providers/providers.dart';
import 'widgets/overview_section.dart';
import 'widgets/weekly_chart.dart';
import 'widgets/pattern_card.dart';

/// Insights screen showing analytics and patterns
class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          const OverviewSection(),
          const SizedBox(height: 32),
          _buildChartsSection(ref),
          const SizedBox(height: 32),
          _buildPatternsSection(ref),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insights',
          style: ArvionTypography.headlineMedium.copyWith(
            color: ArvionColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Your productivity patterns and achievements',
          style: ArvionTypography.bodyMedium.copyWith(
            color: ArvionColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildChartsSection(WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Activity',
          style: ArvionTypography.titleMedium.copyWith(
            color: ArvionColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        const WeeklyChart(),
      ],
    );
  }

  Widget _buildPatternsSection(WidgetRef ref) {
    final patternsAsync = ref.watch(insightPatternsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patterns & Achievements',
          style: ArvionTypography.titleMedium.copyWith(
            color: ArvionColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        patternsAsync.when(
          data: (patterns) => Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              PatternCard(
                icon: Icons.local_fire_department,
                title: 'Current Streak',
                value: '${patterns.currentStreak} days',
                color: ArvionColors.warning,
                subtitle: patterns.currentStreak > 0
                    ? 'Keep it going!'
                    : 'Start today!',
              ),
              PatternCard(
                icon: Icons.emoji_events,
                title: 'Longest Streak',
                value: '${patterns.longestStreak} days',
                color: ArvionColors.primary,
                subtitle: 'Personal best',
              ),
              PatternCard(
                icon: Icons.calendar_today,
                title: 'Best Day',
                value: patterns.mostProductiveDay,
                color: ArvionColors.info,
                subtitle: 'Most active',
              ),
              PatternCard(
                icon: Icons.speed,
                title: 'Consistency',
                value: '${patterns.consistencyScore}%',
                color: ArvionColors.success,
                subtitle: 'Last 30 days',
              ),
            ],
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: ArvionColors.primary),
          ),
          error: (e, _) => Text('Error: $e'),
        ),
      ],
    );
  }
}
