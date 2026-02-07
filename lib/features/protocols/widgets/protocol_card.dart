import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../data/models/protocol.dart';

class ProtocolCard extends StatelessWidget {
  final Protocol protocol;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  const ProtocolCard({
    super.key,
    required this.protocol,
    required this.onComplete,
    required this.onDelete,
  });

  bool get isCompletedToday {
    if (protocol.lastCompletedAt == null) return false;
    final now = DateTime.now();
    final last = protocol.lastCompletedAt!;
    return last.year == now.year &&
        last.month == now.month &&
        last.day == now.day;
  }

  Color get _color =>
      Color(int.parse(protocol.colorHex.replaceFirst('#', '0xFF')));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ArvionColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ArvionColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Color strip
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            protocol.title,
                            style: ArvionTypography.titleMedium.copyWith(
                              color: ArvionColors.textPrimary,
                              decoration: isCompletedToday
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        if (protocol.currentStreak > 0) ...[
                          Icon(
                            Icons.local_fire_department,
                            size: 16,
                            color: ArvionColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${protocol.currentStreak}',
                            style: ArvionTypography.labelSmall.copyWith(
                              color: ArvionColors.warning,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getScheduleText(),
                      style: ArvionTypography.bodySmall.copyWith(
                        color: ArvionColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isCompletedToday
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: isCompletedToday
                          ? ArvionColors.success
                          : ArvionColors.textMuted,
                      size: 28,
                    ),
                    onPressed: isCompletedToday ? null : onComplete,
                    tooltip: isCompletedToday
                        ? 'Completed today'
                        : 'Mark complete',
                  ),
                  PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: ArvionColors.textMuted,
                    ),
                    onSelected: (value) {
                      if (value == 'delete') onDelete();
                    },
                    itemBuilder: (context) => [
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
            ),
          ],
        ),
      ),
    );
  }

  String _getScheduleText() {
    switch (protocol.frequency) {
      case ProtocolFrequency.daily:
        return 'Every day';
      case ProtocolFrequency.weekly:
      case ProtocolFrequency.custom:
        if (protocol.daysOfWeek.length == 7) return 'Every day';
        if (protocol.daysOfWeek.isEmpty) return 'No days set';
        final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        return protocol.daysOfWeek.map((d) => days[d]).join(', ');
    }
  }
}
