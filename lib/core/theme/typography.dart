import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Arvion Typography System
/// Text: Inter (clean, modern)
/// Data/Numbers: JetBrains Mono (developer aesthetic)
class ArvionTypography {
  ArvionTypography._();

  // Base text styles using Inter
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle get displayMedium =>
      GoogleFonts.inter(fontSize: 45, fontWeight: FontWeight.w400);

  static TextStyle get displaySmall =>
      GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w400);

  static TextStyle get headlineLarge =>
      GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w600);

  static TextStyle get headlineMedium =>
      GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w600);

  static TextStyle get headlineSmall =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w500);

  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static TextStyle get titleSmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Monospace styles for data/numbers using JetBrains Mono
  static TextStyle get monoLarge =>
      GoogleFonts.jetBrainsMono(fontSize: 24, fontWeight: FontWeight.w500);

  static TextStyle get monoMedium =>
      GoogleFonts.jetBrainsMono(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get monoSmall =>
      GoogleFonts.jetBrainsMono(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get monoXSmall =>
      GoogleFonts.jetBrainsMono(fontSize: 12, fontWeight: FontWeight.w400);

  // Build complete TextTheme
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
