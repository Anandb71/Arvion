import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/color_utils.dart';
import '../../../providers/providers.dart';

/// High-performance contribution heatmap grid with multi-color support
/// Uses CustomPainter for optimal rendering at 60-120 FPS
class HeatmapGrid extends StatefulWidget {
  final Map<int, HeatmapCellInfo>? multiColorData;
  final Map<int, int>? data; // Backward compatible simple data
  final int weeks;
  final DateTime? startDate;
  final Function(DateTime date)? onCellTap;
  final Function(DateTime date)? onCellHover;
  final bool animate;

  const HeatmapGrid({
    super.key,
    this.multiColorData,
    this.data,
    this.weeks = 52,
    this.startDate,
    this.onCellTap,
    this.onCellHover,
    this.animate = true,
  });

  @override
  State<HeatmapGrid> createState() => _HeatmapGridState();
}

class _HeatmapGridState extends State<HeatmapGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int? _hoveredDayIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.heatmapCompileAnimation,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    if (widget.animate) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  DateTime _getStartDate() {
    if (widget.startDate != null) return widget.startDate!;
    final now = DateTime.now();
    final daysToSubtract = now.weekday % 7 + (widget.weeks - 1) * 7;
    return now.subtract(Duration(days: daysToSubtract));
  }

  int _getDayIndex(DateTime date) {
    return date.difference(DateTime(1970, 1, 1)).inDays;
  }

  DateTime _dateFromDayIndex(int dayIndex) {
    return DateTime(1970, 1, 1).add(Duration(days: dayIndex));
  }

  void _handleHover(Offset localPosition, double cellSize, double cellGap) {
    final totalCellSize = cellSize + cellGap;
    final col = (localPosition.dx / totalCellSize).floor();
    final row = (localPosition.dy / totalCellSize).floor();

    if (row >= 0 && row < 7 && col >= 0 && col < widget.weeks) {
      final startDate = _getStartDate();
      final date = startDate.add(Duration(days: col * 7 + row));
      final dayIndex = _getDayIndex(date);

      if (_hoveredDayIndex != dayIndex) {
        setState(() => _hoveredDayIndex = dayIndex);
        widget.onCellHover?.call(date);
      }
    } else if (_hoveredDayIndex != null) {
      setState(() => _hoveredDayIndex = null);
    }
  }

  void _handleTap(Offset localPosition, double cellSize, double cellGap) {
    final totalCellSize = cellSize + cellGap;
    final col = (localPosition.dx / totalCellSize).floor();
    final row = (localPosition.dy / totalCellSize).floor();

    if (row >= 0 && row < 7 && col >= 0 && col < widget.weeks) {
      final startDate = _getStartDate();
      final date = startDate.add(Duration(days: col * 7 + row));
      widget.onCellTap?.call(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive cell size based on available width
        final availableWidth = constraints.maxWidth - 32; // minus day labels
        final cellGap = 3.0;
        final cellSize =
            ((availableWidth - (widget.weeks - 1) * cellGap) / widget.weeks)
                .clamp(6.0, 12.0);
        final totalCellSize = cellSize + cellGap;

        final width = widget.weeks * totalCellSize;
        final height = 7 * totalCellSize;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day labels
                  SizedBox(
                    width: 20,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                          .map(
                            (day) => SizedBox(
                              height: cellSize,
                              child: Center(
                                child: Text(
                                  day,
                                  style: ArvionTypography.labelSmall.copyWith(
                                    color: ArvionColors.textMuted,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Heatmap grid
                  MouseRegion(
                    onHover: (e) =>
                        _handleHover(e.localPosition, cellSize, cellGap),
                    onExit: (_) => setState(() => _hoveredDayIndex = null),
                    child: GestureDetector(
                      onTapDown: (d) =>
                          _handleTap(d.localPosition, cellSize, cellGap),
                      child: ListenableBuilder(
                        listenable: _animation,
                        builder: (context, child) {
                          return CustomPaint(
                            size: Size(width, height),
                            painter: _MultiColorHeatmapPainter(
                              multiColorData: widget.multiColorData,
                              simpleData: widget.data,
                              weeks: widget.weeks,
                              startDate: _getStartDate(),
                              hoveredDayIndex: _hoveredDayIndex,
                              animationValue: _animation.value,
                              cellSize: cellSize,
                              cellGap: cellGap,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Tooltip
            if (_hoveredDayIndex != null) _buildTooltip(),
          ],
        );
      },
    );
  }

  Widget _buildTooltip() {
    final date = _dateFromDayIndex(_hoveredDayIndex!);
    final cellInfo = widget.multiColorData?[_hoveredDayIndex!];
    final intensity =
        cellInfo?.totalIntensity ?? widget.data?[_hoveredDayIndex!] ?? 0;
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

    String taskInfo = '';
    if (cellInfo != null && cellInfo.contributions.isNotEmpty) {
      taskInfo =
          ' • ${cellInfo.contributions.map((c) => c.taskTitle).join(', ')}';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: ArvionColors.surfaceLighter,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ArvionColors.border),
        ),
        child: Text(
          '$intensity commits on ${months[date.month - 1]} ${date.day}, ${date.year}$taskInfo',
          style: ArvionTypography.bodySmall.copyWith(
            color: ArvionColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _MultiColorHeatmapPainter extends CustomPainter {
  final Map<int, HeatmapCellInfo>? multiColorData;
  final Map<int, int>? simpleData;
  final int weeks;
  final DateTime startDate;
  final int? hoveredDayIndex;
  final double animationValue;
  final double cellSize;
  final double cellGap;

  _MultiColorHeatmapPainter({
    this.multiColorData,
    this.simpleData,
    required this.weeks,
    required this.startDate,
    this.hoveredDayIndex,
    required this.animationValue,
    required this.cellSize,
    required this.cellGap,
  });


  @override
  void paint(Canvas canvas, Size size) {
    final cellRadius = 2.0;
    final totalCellSize = cellSize + cellGap;

    final paint = Paint()..style = PaintingStyle.fill;
    final glowPaint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final epoch = DateTime(1970, 1, 1);
    final totalCells = weeks * 7;
    final animatedCells = (totalCells * animationValue).floor();

    for (int col = 0; col < weeks; col++) {
      for (int row = 0; row < 7; row++) {
        final cellIndex = col * 7 + row;
        if (cellIndex >= animatedCells) continue;

        final date = startDate.add(Duration(days: cellIndex));
        final dayIndex = date.difference(epoch).inDays;

        final x = col * totalCellSize;
        final y = row * totalCellSize;
        final rect = Rect.fromLTWH(x, y, cellSize, cellSize);

        // Get cell data
        final cellInfo = multiColorData?[dayIndex];
        final simpleIntensity = simpleData?[dayIndex] ?? 0;

        // Draw cell
        if (cellInfo != null && cellInfo.contributions.isNotEmpty) {
          // Multi-color cell - split into segments
          _drawMultiColorCell(
            canvas,
            rect,
            cellRadius,
            cellInfo.contributions,
            isHovered: hoveredDayIndex == dayIndex,
            glowPaint: glowPaint,
          );
        } else {
          // Simple single-color cell
          final intensity = simpleIntensity.clamp(0, 5);
          paint.color = ArvionColors.heatmapGreen[intensity];
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(cellRadius)),
            paint,
          );

          // Glow for hovered
          if (hoveredDayIndex == dayIndex && intensity > 0) {
            glowPaint.color = ArvionColors.heatmapGreen[intensity].withValues(
              alpha: 0.4,
            );
            canvas.drawRRect(
              RRect.fromRectAndRadius(
                rect.inflate(2),
                Radius.circular(cellRadius + 2),
              ),
              glowPaint,
            );
          }
        }

        // Draw hover border
        if (hoveredDayIndex == dayIndex) {
          final borderPaint = Paint()
            ..style = PaintingStyle.stroke
            ..color = ArvionColors.textPrimary.withValues(alpha: 0.5)
            ..strokeWidth = 1;
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(cellRadius)),
            borderPaint,
          );
        }
      }
    }
  }

  void _drawMultiColorCell(
    Canvas canvas,
    Rect rect,
    double radius,
    List<TaskContribution> contributions, {
    required bool isHovered,
    required Paint glowPaint,
  }) {
    final paint = Paint()..style = PaintingStyle.fill;

    if (contributions.length == 1) {
      // Single color
      final color = ColorUtils.hexToColor(contributions.first.colorHex);
      paint.color = color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius)),
        paint,
      );

      if (isHovered) {
        glowPaint.color = color.withValues(alpha: 0.4);
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect.inflate(2), Radius.circular(radius + 2)),
          glowPaint,
        );
      }
    } else if (contributions.length == 2) {
      // Split diagonally for 2 colors
      final color1 = ColorUtils.hexToColor(contributions[0].colorHex);
      final color2 = ColorUtils.hexToColor(contributions[1].colorHex);

      // Top-left triangle
      final path1 = Path()
        ..moveTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top)
        ..lineTo(rect.left, rect.bottom)
        ..close();

      // Bottom-right triangle
      final path2 = Path()
        ..moveTo(rect.right, rect.top)
        ..lineTo(rect.right, rect.bottom)
        ..lineTo(rect.left, rect.bottom)
        ..close();

      canvas.save();
      canvas.clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
      paint.color = color1;
      canvas.drawPath(path1, paint);
      paint.color = color2;
      canvas.drawPath(path2, paint);
      canvas.restore();
    } else {
      // 3+ colors: split into vertical stripes
      final stripeWidth = rect.width / contributions.length;

      canvas.save();
      canvas.clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

      for (int i = 0; i < contributions.length; i++) {
        final color = ColorUtils.hexToColor(contributions[i].colorHex);
        paint.color = color;
        final stripeRect = Rect.fromLTWH(
          rect.left + i * stripeWidth,
          rect.top,
          stripeWidth,
          rect.height,
        );
        canvas.drawRect(stripeRect, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _MultiColorHeatmapPainter oldDelegate) {
    return oldDelegate.multiColorData != multiColorData ||
        oldDelegate.simpleData != simpleData ||
        oldDelegate.hoveredDayIndex != hoveredDayIndex ||
        oldDelegate.animationValue != animationValue;
  }
}

/// Legend for the heatmap intensity levels
class HeatmapLegend extends StatelessWidget {
  final bool useBlueTheme;

  const HeatmapLegend({super.key, this.useBlueTheme = false});

  @override
  Widget build(BuildContext context) {
    final colors = useBlueTheme
        ? ArvionColors.heatmapBlue
        : ArvionColors.heatmapGreen;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Less',
          style: ArvionTypography.labelSmall.copyWith(
            color: ArvionColors.textMuted,
          ),
        ),
        const SizedBox(width: 4),
        ...List.generate(6, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
        const SizedBox(width: 4),
        Text(
          'More',
          style: ArvionTypography.labelSmall.copyWith(
            color: ArvionColors.textMuted,
          ),
        ),
      ],
    );
  }
}

/// Mini heatmap for a single task with custom color
class TaskHeatmapGrid extends StatefulWidget {
  final TaskHeatmapData taskData;
  final int weeks;
  final bool animate;

  const TaskHeatmapGrid({
    super.key,
    required this.taskData,
    this.weeks = 26, // Show 6 months by default
    this.animate = true,
  });

  @override
  State<TaskHeatmapGrid> createState() => _TaskHeatmapGridState();
}

class _TaskHeatmapGridState extends State<TaskHeatmapGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = ColorUtils.hexToColor(widget.taskData.colorHex);
    final colorScale = _generateColorScale(baseColor);
    final cellSize = 8.0;
    final cellGap = 2.0;
    final totalCellSize = cellSize + cellGap;
    final width = widget.weeks * totalCellSize;
    final height = 7 * totalCellSize;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ArvionColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ArvionColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.taskData.taskTitle,
                  style: ArvionTypography.titleSmall.copyWith(
                    color: ArvionColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${widget.taskData.totalCommits} commits',
                style: ArvionTypography.monoXSmall.copyWith(
                  color: ArvionColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(width, height),
                  painter: _TaskHeatmapPainter(
                    data: widget.taskData.data,
                    weeks: widget.weeks,
                    startDate: _getStartDate(),
                    colorScale: colorScale,
                    cellSize: cellSize,
                    cellGap: cellGap,
                    animationValue: _animation.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskHeatmapPainter extends CustomPainter {
  final Map<int, int> data;
  final int weeks;
  final DateTime startDate;
  final List<Color> colorScale;
  final double cellSize;
  final double cellGap;
  final double animationValue;

  _TaskHeatmapPainter({
    required this.data,
    required this.weeks,
    required this.startDate,
    required this.colorScale,
    required this.cellSize,
    required this.cellGap,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final totalCellSize = cellSize + cellGap;
    final paint = Paint()..style = PaintingStyle.fill;
    final epoch = DateTime(1970, 1, 1);

    final totalCells = weeks * 7;
    final visibleCells = (totalCells * animationValue).floor();

    for (int col = 0; col < weeks; col++) {
      for (int row = 0; row < 7; row++) {
        final cellIndex = col * 7 + row;
        if (cellIndex >= visibleCells) continue;

        final date = startDate.add(Duration(days: cellIndex));
        final dayIndex = date.difference(epoch).inDays;
        final intensity = (data[dayIndex] ?? 0).clamp(0, 5);

        final x = col * totalCellSize;
        final y = row * totalCellSize;
        final rect = Rect.fromLTWH(x, y, cellSize, cellSize);

        paint.color = colorScale[intensity];
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(2)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TaskHeatmapPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.animationValue != animationValue;
  }
}
