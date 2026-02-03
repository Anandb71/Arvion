import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../data/repositories/task_repository.dart';
import '../data/repositories/commit_repository.dart';
import '../data/repositories/protocol_repository.dart';
import '../data/models/task.dart';
import '../data/models/commit.dart';
import '../data/models/protocol.dart';

class DataExportService {
  final TaskRepository taskRepo;
  final CommitRepository commitRepo;
  final ProtocolRepository protocolRepo;
  
  DataExportService({
    required this.taskRepo,
    required this.commitRepo,
    required this.protocolRepo,
  });
  
  Future<String?> exportToJson() async {
    try {
      final tasks = await taskRepo.getAll();
      final commits = await commitRepo.getAll();
      final protocols = await protocolRepo.getAll();
      
      final data = {
        'version': '1.0',
        'exportDate': DateTime.now().toIso8601String(),
        'tasks': tasks.map((t) => _taskToJson(t)).toList(),
        'commits': commits.map((c) => _commitToJson(c)).toList(),
        'protocols': protocols.map((p) => _protocolToJson(p)).toList(),
      };
      
      final jsonString = const JsonEncoder.withIndent('  ').convert(data);
      
      // Save file
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Export Data (JSON)',
        fileName: 'arvion_backup_${DateFormat('yyyyMMdd').format(DateTime.now())}.json',
        allowedExtensions: ['json'],
        type: FileType.custom,
      );
      
      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsString(jsonString);
        return outputFile;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to export data: $e');
    }
  }
  
  Future<String?> exportToCsv() async {
     try {
       final commits = await commitRepo.getAll();
       
       final buffer = StringBuffer();
       buffer.writeln('Date,Time,TaskIds,Intensity,Note');
       
       for (final c in commits) {
         final date = DateFormat('yyyy-MM-dd').format(c.timestamp);
         final time = DateFormat('HH:mm:ss').format(c.timestamp);
         final tasks = c.taskIds.join(';');
         final note = c.note?.replaceAll(',', ' ') ?? ''; // Simple csv escaping
         
         buffer.writeln('$date,$time,$tasks,${c.intensity},$note');
       }
       
       // Save file
       String? outputFile = await FilePicker.platform.saveFile(
         dialogTitle: 'Export Commits (CSV)',
         fileName: 'arvion_commits_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv',
         allowedExtensions: ['csv'],
         type: FileType.custom,
       );
       
       if (outputFile != null) {
         final file = File(outputFile);
         await file.writeAsString(buffer.toString());
         return outputFile;
       }
       return null;
     } catch (e) {
       throw Exception('Failed to export CSV: $e');
     }
  }
  
  Map<String, dynamic> _taskToJson(Task t) => {
    'id': t.id,
    'title': t.title,
    'description': t.description,
    'colorHex': t.colorHex,
    'isArchived': t.isArchived,
    'createdAt': t.createdAt.toIso8601String(),
  };
  
  Map<String, dynamic> _commitToJson(Commit c) => {
    'id': c.id,
    'timestamp': c.timestamp.toIso8601String(),
    'intensity': c.intensity,
    'note': c.note,
    'taskIds': c.taskIds,
    'source': c.source.name,
  };
  
  Map<String, dynamic> _protocolToJson(Protocol p) => {
    'id': p.id,
    'title': p.title,
    'description': p.description,
    'colorHex': p.colorHex,
    'frequency': p.frequency.index,
    'daysOfWeek': p.daysOfWeek,
    'reminderTime': p.reminderTime,
    'currentStreak': p.currentStreak,
    'longestStreak': p.longestStreak,
    'totalCompletions': p.totalCompletions,
    'lastCompletedAt': p.lastCompletedAt?.toIso8601String(),
    'isActive': p.isActive,
    'createdAt': p.createdAt.toIso8601String(),
  };
}
