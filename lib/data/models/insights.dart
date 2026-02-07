/// Data class for weekly activity chart
class WeeklyActivity {
  final String label;
  final int commits;
  final DateTime startOfWeek;

  const WeeklyActivity({
    required this.label,
    required this.commits,
    required this.startOfWeek,
  });
}

/// Data class for insight patterns
class InsightPatterns {
  final int currentStreak;
  final int longestStreak;
  final String mostProductiveDay;
  final int consistencyScore; // 0-100

  const InsightPatterns({
    required this.currentStreak,
    required this.longestStreak,
    required this.mostProductiveDay,
    required this.consistencyScore,
  });

  const InsightPatterns.empty()
    : currentStreak = 0,
      longestStreak = 0,
      mostProductiveDay = 'None',
      consistencyScore = 0;
}
