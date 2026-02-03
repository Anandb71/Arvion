import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

/// Arvion Theme Configuration
/// Minimal, OLED-black, neon glow aesthetics
class ArvionTheme {
  ArvionTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Colors
      colorScheme: const ColorScheme.dark(
        primary: ArvionColors.primary,
        secondary: ArvionColors.secondary,
        surface: ArvionColors.surface,
        error: ArvionColors.error,
        onPrimary: ArvionColors.background,
        onSecondary: Colors.white,
        onSurface: ArvionColors.textPrimary,
        onError: Colors.white,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: ArvionColors.background,
      
      // Typography
      textTheme: ArvionTypography.textTheme.apply(
        bodyColor: ArvionColors.textPrimary,
        displayColor: ArvionColors.textPrimary,
      ),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: ArvionColors.background,
        foregroundColor: ArvionColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      
      // Cards
      cardTheme: CardThemeData(
        color: ArvionColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: ArvionColors.border, width: 1),
        ),
      ),
      
      // Dialogs
      dialogTheme: DialogThemeData(
        backgroundColor: ArvionColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ArvionColors.border, width: 1),
        ),
      ),
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ArvionColors.primary,
          foregroundColor: ArvionColors.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ArvionColors.textPrimary,
          side: const BorderSide(color: ArvionColors.border),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ArvionColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ArvionColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ArvionColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ArvionColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ArvionColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: const TextStyle(color: ArvionColors.textMuted),
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: ArvionColors.border,
        thickness: 1,
      ),
      
      // Navigation Rail (for desktop)
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: ArvionColors.surface,
        selectedIconTheme: IconThemeData(color: ArvionColors.primary),
        unselectedIconTheme: IconThemeData(color: ArvionColors.textSecondary),
        indicatorColor: Color(0xFF0E4429),
      ),
      
      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: ArvionColors.surfaceLighter,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ArvionColors.border),
        ),
        textStyle: ArvionTypography.bodySmall.copyWith(
          color: ArvionColors.textPrimary,
        ),
      ),
      
      // Icon
      iconTheme: const IconThemeData(
        color: ArvionColors.textSecondary,
        size: 24,
      ),
      
      // Scrollbar
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(ArvionColors.border),
        radius: const Radius.circular(4),
        thickness: WidgetStateProperty.all(6),
      ),
    );
  }
}
