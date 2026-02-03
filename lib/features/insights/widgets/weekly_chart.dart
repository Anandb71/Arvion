import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../providers/providers.dart';
import '../../../data/models/insights.dart';

/// Weekly activity bar chart
class WeeklyChart extends ConsumerWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyDataAsync = ref.watch(weeklyActivityProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ArvionColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ArvionColors.border),
      ),
      child: weeklyDataAsync.when(
        data: (weeklyData) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Last 8 Weeks',
                  style: ArvionTypography.titleSmall.copyWith(
                    color: ArvionColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${weeklyData.fold<int>(0, (sum, w) => sum + w.commits)} total commits',
                  style: ArvionTypography.monoSmall.copyWith(
                    color: ArvionColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: CustomPaint(
                size: const Size(double.infinity, 200),
                painter: _WeeklyChartPainter(weeklyData: weeklyData),
              ),
            ),
          ],
        ),
        loading: () => const SizedBox(
          height: 250,
          child: Center(
            child: CircularProgressIndicator(color: ArvionColors.primary),
          ),
        ),
        error: (e, _) => SizedBox(
          height: 250,
          child: Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class _WeeklyChartPainter extends CustomPainter {
  final List<WeeklyActivity> weeklyData;

  _WeeklyChartPainter({required this.weeklyData});

  @override
  void paint(Canvas canvas, Size size) {
    if (weeklyData.isEmpty) return;

    final maxCommits = weeklyData.map((w) => w.commits).reduce((a, b) => a > b ? a : b);
    if (maxCommits == 0) return;

    final barWidth = (size.width - (weeklyData.length - 1) * 8) / weeklyData.length;
    final paint = Paint()..style = PaintingStyle.fill;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw bars
    for (int i = 0; i < weeklyData.length; i++) {
      final week = weeklyData[i];
      final barHeight = (week.commits / maxCommits) * (size.height - 40);
      final x = i * (barWidth + 8);
      final y = size.height - 30 - barHeight;

      // Bar gradient based on intensity
      final intensity = (week.commits / maxCommits).clamp(0.2, 1.0);
      paint.color = ArvionColors.primary.withValues(alpha: intensity);

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, paint);

      // Commit count on top
      if (barHeight > 20) {
        textPainter.text = TextSpan(
          text: week.commits.toString(),
          style: ArvionTypography.monoXSmall.copyWith(
            color: ArvionColors.textPrimary,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x + (barWidth - textPainter.width) / 2, y - 18),
        );
      }

      // Week label
      textPainter.text = TextSpan(
        text: week.label,
        style: ArvionTypography.labelSmall.copyWith(
          color: ArvionColors.textMuted,
          fontSize: 9,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + (barWidth - textPainter.width) / 2, size.height - 20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WeeklyChartPainter oldDelegate) {
    return oldDelegate.weeklyData != weeklyData;
  }
}
