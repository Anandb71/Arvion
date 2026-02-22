import 'package:flutter/material.dart';

/// Utilities for color manipulation
class ColorUtils {
  ColorUtils._();

  /// Converts a hex string (e.g., "#FF0000" or "FF0000") to a Color object
  static Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  /// Darkens a color by a specific percentage
  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsv = HSVColor.fromColor(color);
    return hsv.withValue((hsv.value - amount).clamp(0.0, 1.0)).toColor();
  }

  /// Lightens a color by a specific percentage
  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsv = HSVColor.fromColor(color);
    return hsv.withValue((hsv.value + amount).clamp(0.0, 1.0)).toColor();
  }
}
