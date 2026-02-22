import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../providers/providers.dart';
import '../../insights/screen_time_details.dart';

class ScreenTimeCard extends ConsumerWidget {
  const ScreenTimeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenTimeAsync = ref.watch(todayScreenTimeProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ArvionColors.surfaceLight,
            ArvionColors.secondary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ArvionColors.border),
      ),
      child: screenTimeAsync.when(
        data: (totalSeconds) => _buildContent(context, ref, totalSeconds),
        loading: () => _buildLoading(),
        error: (_, __) => _buildError(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final percentage = (totalSeconds / (16 * 3600)).clamp(0.0, 1.0);
    final repo = ref.watch(screenTimeRepositoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with navigation
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ArvionColors.secondary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.timer_outlined,
                size: 20,
                color: ArvionColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Screen Time',
                style: ArvionTypography.labelMedium.copyWith(
                  color: ArvionColors.textSecondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScreenTimeDetailsScreen(),
                ),
              ),
              child: Text(
                'View Details',
                style: ArvionTypography.labelSmall.copyWith(
                  color: ArvionColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Big time display
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$hours',
              style: ArvionTypography.headlineLarge.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: ArvionColors.textPrimary,
              ),
            ),
            Text(
              'h ',
              style: ArvionTypography.headlineSmall.copyWith(
                color: ArvionColors.textMuted,
              ),
            ),
            Text(
              '$minutes',
              style: ArvionTypography.headlineLarge.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: ArvionColors.textPrimary,
              ),
            ),
            Text(
              'm',
              style: ArvionTypography.headlineSmall.copyWith(
                color: ArvionColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 10,
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
        const SizedBox(height: 12),

        // Top apps quick view
        FutureBuilder(
          future: repo.getTopApps(DateTime.now(), limit: 3),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text(
                'Start using apps to see your top apps here',
                style: ArvionTypography.labelSmall.copyWith(
                  color: ArvionColors.textMuted,
                ),
              );
            }

            final topApps = snapshot.data!;
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: topApps.map((app) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ArvionColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ArvionColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        app.appName,
                        style: ArvionTypography.labelSmall.copyWith(
                          color: ArvionColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        app.formattedDuration,
                        style: ArvionTypography.labelSmall.copyWith(
                          color: ArvionColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 140,
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
      height: 140,
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
