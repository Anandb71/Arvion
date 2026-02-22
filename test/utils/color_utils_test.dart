import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:arvion/core/utils/color_utils.dart';

void main() {
  group('ColorUtils Tests', () {
    test('hexToColor converts 6-char hex correctly', () {
      final color = ColorUtils.hexToColor('FF0000');
      expect(color.r, 1.0);
      expect(color.g, 0.0);
      expect(color.b, 0.0);
      expect(color.a, 1.0);
    });

    test('hexToColor handles hash prefix', () {
      final color = ColorUtils.hexToColor('#00FF00');
      expect(color.r, 0.0);
      expect(color.g, 1.0);
      expect(color.b, 0.0);
    });

    test('darken reduces value', () {
      final color = const Color(0xFF808080); // Middle gray
      final darker = ColorUtils.darken(color, 0.2);
      
      final originalHsv = HSVColor.fromColor(color);
      final darkerHsv = HSVColor.fromColor(darker);
      
      expect(darkerHsv.value, lessThan(originalHsv.value));
    });

    test('lighten increases value', () {
      final color = const Color(0xFF808080);
      final lighter = ColorUtils.lighten(color, 0.2);
      
      final originalHsv = HSVColor.fromColor(color);
      final lighterHsv = HSVColor.fromColor(lighter);
      
      expect(lighterHsv.value, greaterThan(originalHsv.value));
    });
  });
}
