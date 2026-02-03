import 'package:flutter/material.dart';

/// Arvion Design System Colors
/// Primary: Growth Green #00D26A
/// Secondary: GitHub Blue #0969DA
/// Background: OLED Black #000000
class ArvionColors {
  ArvionColors._();

  // Primary Colors
  static const Color primary = Color(0xFF00D26A);
  static const Color secondary = Color(0xFF0969DA);
  
  // Background Colors
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF0D1117);
  static const Color surfaceLight = Color(0xFF161B22);
  static const Color surfaceLighter = Color(0xFF21262D);
  static const Color cardBg = Color(0xFF161B22);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFE6EDF3);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted = Color(0xFF484F58);
  
  // Heatmap Intensity Levels (GitHub-style)
  static const List<Color> heatmapGreen = [
    Color(0xFF161B22), // Level 0 - empty
    Color(0xFF0E4429), // Level 1
    Color(0xFF006D32), // Level 2
    Color(0xFF26A641), // Level 3
    Color(0xFF39D353), // Level 4
    Color(0xFF00D26A), // Level 5 - max (primary)
  ];
  
  static const List<Color> heatmapBlue = [
    Color(0xFF161B22), // Level 0 - empty
    Color(0xFF0A3069), // Level 1
    Color(0xFF0550AE), // Level 2
    Color(0xFF0969DA), // Level 3
    Color(0xFF218BFF), // Level 4
    Color(0xFF58A6FF), // Level 5 - max
  ];
  
  // Glow Colors (for neon effects)
  static const Color glowGreen = Color(0xFF00D26A);
  static const Color glowBlue = Color(0xFF0969DA);
  
  // Status Colors
  static const Color success = Color(0xFF3FB950);
  static const Color warning = Color(0xFFD29922);
  static const Color error = Color(0xFFF85149);
  static const Color info = Color(0xFF58A6FF);
  
  // Border Colors
  static const Color border = Color(0xFF30363D);
  static const Color borderLight = Color(0xFF484F58);
}
