import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../providers/providers.dart';

class ScreenTimeCard extends ConsumerWidget {
  const ScreenTimeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenTimeAsync = ref.watch(todayScreenTimeProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ArvionColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ArvionColors.border),
      ),
      child: screenTimeAsync.when(
        data: (totalSeconds) => _buildContent(context, totalSeconds),
        loading: () => _buildLoading(),
        error: (_, __) => _buildError(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int totalSeconds) {
    final hours = (totalSeconds / 3600).toStringAsFixed(1);
    final percentage = (totalSeconds / (16 * 3600)).clamp(0.0, 1.0); // 16 waking hours

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ArvionColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.access_time,
                size: 20,
                color: ArvionColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Screen Time Today',
              style: ArvionTypography.labelMedium.copyWith(
                color: ArvionColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              hours,
              style: ArvionTypography.headlineLarge.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: ArvionColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'hours',
              style: ArvionTypography.bodyMedium.copyWith(
                color: ArvionColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 8,
            backgroundColor: ArvionColors.surface,
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage > 0.8
                  ? ArvionColors.error
                  : percentage > 0.5
                      ? ArvionColors.warning
                      : ArvionColors.secondary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${(percentage * 100).toInt()}% of recommended waking hours',
          style: ArvionTypography.labelSmall.copyWith(
            color: ArvionColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(
            color: ArvionColors.secondary,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildError() {
    return SizedBox(
      height: 120,
      child: Center(
        child: Text(
          'Unable to load screen time',
          style: ArvionTypography.bodySmall.copyWith(
            color: ArvionColors.textMuted,
          ),
        ),
      ),
    );
  }
}
