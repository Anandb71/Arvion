import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../providers/providers.dart';
import '../../data/repositories/screen_time_repository.dart';

/// Detailed Screen Time Insights Screen
class ScreenTimeDetailsScreen extends ConsumerStatefulWidget {
  const ScreenTimeDetailsScreen({super.key});

  @override
  ConsumerState<ScreenTimeDetailsScreen> createState() =>
      _ScreenTimeDetailsScreenState();
}

class _ScreenTimeDetailsScreenState
    extends ConsumerState<ScreenTimeDetailsScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(screenTimeRepositoryProvider);

    return Scaffold(
      backgroundColor: ArvionColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ArvionColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Screen Time',
          style: ArvionTypography.headlineMedium.copyWith(
            color: ArvionColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today,
              color: ArvionColors.textSecondary,
            ),
            onPressed: _selectDate,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateHeader(),
            const SizedBox(height: 24),
            _buildTotalTimeCard(repo),
            const SizedBox(height: 24),
            _buildTopAppsSection(repo),
            const SizedBox(height: 24),
            _buildHourlyChart(repo),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
    final isToday =
        _selectedDate.day == DateTime.now().day &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.year == DateTime.now().year;

    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: ArvionColors.textSecondary,
          ),
          onPressed: () => setState(
            () =>
                _selectedDate = _selectedDate.subtract(const Duration(days: 1)),
          ),
        ),
        Text(
          isToday
              ? 'Today'
              : '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
          style: ArvionTypography.headlineSmall.copyWith(
            color: ArvionColors.textPrimary,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.chevron_right,
            color: ArvionColors.textSecondary,
          ),
          onPressed: _selectedDate.isBefore(DateTime.now())
              ? () => setState(
                  () => _selectedDate = _selectedDate.add(
                    const Duration(days: 1),
                  ),
                )
              : null,
        ),
      ],
    );
  }

  Widget _buildTotalTimeCard(ScreenTimeRepository repo) {
    return FutureBuilder<int>(
      future: repo.getDailyTotal(_selectedDate),
      builder: (context, snapshot) {
        final totalSeconds = snapshot.data ?? 0;
        final hours = totalSeconds ~/ 3600;
        final minutes = (totalSeconds % 3600) ~/ 60;

        return FutureBuilder<int>(
          future: repo.getDailyActiveTime(_selectedDate),
          builder: (context, activeSnapshot) {
            final activeSeconds = activeSnapshot.data ?? 0;
            final idleSeconds = totalSeconds - activeSeconds;
            final activePercent = totalSeconds > 0
                ? (activeSeconds / totalSeconds * 100).round()
                : 0;

            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ArvionColors.primary.withOpacity(0.15),
                    ArvionColors.secondary.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: ArvionColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$hours',
                        style: ArvionTypography.headlineLarge.copyWith(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: ArvionColors.textPrimary,
                        ),
                      ),
                      Text(
                        'h ',
                        style: ArvionTypography.headlineMedium.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                      Text(
                        '$minutes',
                        style: ArvionTypography.headlineLarge.copyWith(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: ArvionColors.textPrimary,
                        ),
                      ),
                      Text(
                        'm',
                        style: ArvionTypography.headlineMedium.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatChip(
                        'Active',
                        _formatDuration(activeSeconds),
                        ArvionColors.primary,
                      ),
                      _buildStatChip(
                        'Idle',
                        _formatDuration(idleSeconds),
                        ArvionColors.warning,
                      ),
                      _buildStatChip(
                        'Focus',
                        '$activePercent%',
                        ArvionColors.secondary,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: ArvionTypography.headlineSmall.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: ArvionTypography.labelSmall.copyWith(
            color: ArvionColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildTopAppsSection(ScreenTimeRepository repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Apps',
          style: ArvionTypography.headlineSmall.copyWith(
            color: ArvionColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<AppUsage>>(
          future: repo.getTopApps(_selectedDate, limit: 5),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: ArvionColors.surfaceLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'No data yet',
                    style: ArvionTypography.bodyMedium.copyWith(
                      color: ArvionColors.textMuted,
                    ),
                  ),
                ),
              );
            }

            final apps = snapshot.data!;
            final maxSeconds = apps.first.totalSeconds;

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ArvionColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ArvionColors.border),
              ),
              child: Column(
                children: apps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final app = entry.value;
                  final percentage = maxSeconds > 0
                      ? app.totalSeconds / maxSeconds
                      : 0.0;
                  final colors = [
                    ArvionColors.primary,
                    ArvionColors.secondary,
                    ArvionColors.warning,
                    Colors.purple,
                    Colors.teal,
                  ];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < apps.length - 1 ? 16 : 0,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            app.appName,
                            style: ArvionTypography.bodyMedium.copyWith(
                              color: ArvionColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percentage,
                              minHeight: 20,
                              backgroundColor: ArvionColors.surface,
                              valueColor: AlwaysStoppedAnimation(
                                colors[index % colors.length],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 50,
                          child: Text(
                            app.formattedDuration,
                            style: ArvionTypography.labelMedium.copyWith(
                              color: ArvionColors.textSecondary,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHourlyChart(ScreenTimeRepository repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hourly Activity',
          style: ArvionTypography.headlineSmall.copyWith(
            color: ArvionColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        FutureBuilder<Map<int, int>>(
          future: repo.getHourlyBreakdown(_selectedDate),
          builder: (context, snapshot) {
            final hourlyData = snapshot.data ?? {};
            final maxValue = hourlyData.values.fold(0, (a, b) => a > b ? a : b);

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ArvionColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ArvionColors.border),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(24, (hour) {
                        final value = hourlyData[hour] ?? 0;
                        final height = maxValue > 0
                            ? (value / maxValue * 100)
                            : 0.0;
                        final isCurrentHour =
                            hour == DateTime.now().hour && _isToday();

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Container(
                              height: height.clamp(4.0, 100.0),
                              decoration: BoxDecoration(
                                color: isCurrentHour
                                    ? ArvionColors.primary
                                    : ArvionColors.secondary.withValues(
                                        alpha: 0.7,
                                      ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '12AM',
                        style: ArvionTypography.labelSmall.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                      Text(
                        '6AM',
                        style: ArvionTypography.labelSmall.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                      Text(
                        '12PM',
                        style: ArvionTypography.labelSmall.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                      Text(
                        '6PM',
                        style: ArvionTypography.labelSmall.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                      Text(
                        '12AM',
                        style: ArvionTypography.labelSmall.copyWith(
                          color: ArvionColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  bool _isToday() {
    final now = DateTime.now();
    return _selectedDate.day == now.day &&
        _selectedDate.month == now.month &&
        _selectedDate.year == now.year;
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(primary: ArvionColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }
}
