import 'package:flutter_test/flutter_test.dart';
import 'package:arvion/data/models/task.dart';
import 'dart:convert';

void main() {
  group('Task Model Tests', () {
    test('Task creation sets default values correctly', () {
      final task = Task.create(
        title: 'Test Task',
        colorHex: '#FF0000',
      );

      expect(task.title, 'Test Task');
      expect(task.colorHex, '#FF0000');
      expect(task.difficulty, 2);
      expect(task.verificationType, VerificationType.manual);
      expect(task.isArchived, false);
      expect(task.totalCommits, 0);
      expect(task.currentStreak, 0);
    });

    test('App Usage verification config is correctly serialized', () {
      final task = Task.create(
        title: 'Coding',
        colorHex: '#00FF00',
        verificationType: VerificationType.appUsage,
      );

      final config = {
        'app_name': 'VS Code',
        'duration_minutes': 45,
      };

      task.verificationConfig = jsonEncode(config);

      expect(task.verificationType, VerificationType.appUsage);
      expect(task.verificationConfig, isNotNull);

      final decoded = jsonDecode(task.verificationConfig!);
      expect(decoded['app_name'], 'VS Code');
      expect(decoded['duration_minutes'], 45);
    });

    test('Task validation logic', () {
      final task = Task.create(title: '', colorHex: '');
      // Assuming we had validation logic, but Isar models are permissive.
      // This test documents expected behavior.
      expect(task.title, isEmpty);
    });
  });
}
