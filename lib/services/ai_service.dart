import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/repositories/task_repository.dart';
import '../data/models/task.dart';

/// Message model for specific UI needs
class AIMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  AIMessage({
    required this.content,
    required this.isUser,
  }) : timestamp = DateTime.now();
}

/// AI Service connecting to Google Gemini
class AIService {
  final TaskRepository taskRepository;

  static const _storage = FlutterSecureStorage();
  static const _apiKeyKey = 'gemini_api_key';
  static const _defaultModel = 'gemini-1.5-flash';
  static const _modelKey = 'gemini_model';

  AIService({required this.taskRepository});

  /// Define the 'create_task' tool
  static final _createTaskTool = Tool(
    functionDeclarations: [
      FunctionDeclaration(
        'create_task',
        'Creates a new task in the user\'s list.',
        Schema(
          SchemaType.object,
          properties: {
            'title': Schema(SchemaType.string, description: 'Title of the task (e.g., "Read a book")'),
            'description': Schema(SchemaType.string, description: 'Optional description'),
            'difficulty': Schema(SchemaType.integer, description: 'Difficulty level from 1 (Easy) to 5 (Hard). Default is 2.'),
          },
          requiredProperties: ['title'],
        ),
      ),
    ],
  );

  /// Define the 'list_tasks' tool
  static final _listTasksTool = Tool(
    functionDeclarations: [
      FunctionDeclaration(
        'list_tasks',
        'Lists all active tasks with their IDs and details.',
        Schema(
          SchemaType.object,
          properties: {}, // No arguments needed
        ),
      ),
    ],
  );

  /// Define the 'update_task' tool
  static final _updateTaskTool = Tool(
    functionDeclarations: [
      FunctionDeclaration(
        'update_task',
        'Updates an existing task.',
        Schema(
          SchemaType.object,
          properties: {
            'id': Schema(SchemaType.integer, description: 'ID of the task to update'),
            'title': Schema(SchemaType.string, description: 'New title'),
            'isArchived': Schema(SchemaType.boolean, description: 'Set to true to archive/complete'),
            'difficulty': Schema(SchemaType.integer, description: 'New difficulty level'),
          },
          requiredProperties: ['id'],
        ),
      ),
    ],
  );

  /// Define the 'delete_task' tool
  static final _deleteTaskTool = Tool(
    functionDeclarations: [
      FunctionDeclaration(
        'delete_task',
        'Permanently deletes a task.',
        Schema(
          SchemaType.object,
          properties: {
            'id': Schema(SchemaType.integer, description: 'ID of the task to delete'),
          },
          requiredProperties: ['id'],
        ),
      ),
    ],
  );

  /// Stream message from Gemini
  Stream<String> sendMessageStream(String userMessage) async* {
    final apiKey = await _storage.read(key: _apiKeyKey);
    
    // Get selected model
    final prefs = await SharedPreferences.getInstance();
    final modelName = prefs.getString(_modelKey) ?? _defaultModel;

    if (apiKey == null || apiKey.isEmpty) {
      yield "⚠️ **Setup Required**\n\n"
          "Please enter your Google Gemini API Key in **Settings** to enable the assistant.\n\n"
          "You can get a free key at [aistudio.google.com](https://aistudio.google.com/app/apikey).";
      return;
    }

    try {
      final model = GenerativeModel(
        model: modelName,
        apiKey: apiKey,
        tools: [
          _createTaskTool,
          _listTasksTool,
          _updateTaskTool,
          _deleteTaskTool,
        ],
        generationConfig: GenerationConfig(
          temperature: 0.7,
          maxOutputTokens: 2048, // Increased for list tasks
          stopSequences: ['**User', 'User:'],
        ),
      );

      final chat = model.startChat(history: [
        Content.text(_buildSystemPrompt()),
      ]);

      // Send message and get response (could be text or function call)
      var response = await chat.sendMessage(Content.text(userMessage));

      // Handle function calls loop (supports sequential calls)
      while (response.functionCalls.isNotEmpty) {
        final functionCall = response.functionCalls.first;
        Map<String, Object?> result;
        
        try {
          if (functionCall.name == 'create_task') {
             yield "🛠️ Creating task: ${functionCall.args['title']}...";
             result = await _performCreateTask(functionCall.args);
          } else if (functionCall.name == 'list_tasks') {
             yield "📋 Reading tasks...";
             result = await _performListTasks();
          } else if (functionCall.name == 'update_task') {
             yield "✏️ Updating task ${functionCall.args['id']}...";
             result = await _performUpdateTask(functionCall.args);
          } else if (functionCall.name == 'delete_task') {
             yield "🗑️ Deleting task ${functionCall.args['id']}...";
             result = await _performDeleteTask(functionCall.args);
          } else {
             result = {'error': 'Unknown function ${functionCall.name}'};
          }
        } catch (e) {
          result = {'error': e.toString()};
        }

        // Send result back to model
        response = await chat.sendMessage(
          Content.functionResponse(functionCall.name, result),
        );
      }

      // Yield final text response
      if (response.text != null) {
        yield response.text!;
      }

    } catch (e) {
      yield "❌ **Error**\n\n`$e`";
    }
  }

  /// Helper to execute create_task
  Future<Map<String, Object?>> _performCreateTask(Map<String, Object?> args) async {
    try {
      final title = args['title'] as String;
      final description = args['description'] as String?;
      final difficulty = (args['difficulty'] as int?) ?? 2;

      // Random color logic could be improved, limiting to green for now
      const defaultColor = '#00D26A'; 

      final newTask = Task.create(
        title: title,
        description: description,
        colorHex: defaultColor,
        difficulty: difficulty,
      );

      final id = await taskRepository.create(newTask);
      return {'status': 'success', 'taskId': id, 'message': 'Task "$title" created successfully.'};
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  /// Helper to list tasks
  Future<Map<String, Object?>> _performListTasks() async {
    try {
      final tasks = await taskRepository.getAllActive();
      // Only send minimal info to save context
      final tasksData = tasks.map((t) => {
        'id': t.id,
        'title': t.title,
        'difficulty': t.difficulty,
        'streak': t.currentStreak,
      }).toList();
      return {'status': 'success', 'tasks': tasksData, 'count': tasksData.length};
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  /// Helper to update tasks
  Future<Map<String, Object?>> _performUpdateTask(Map<String, Object?> args) async {
    try {
      // Cast safely since args comes from JSON
      final idRaw = args['id'];
      if (idRaw == null) return {'status': 'error', 'message': 'Task ID required'};
      final id = idRaw is int ? idRaw : int.parse(idRaw.toString());

      final task = await taskRepository.getById(id);
      if (task == null) return {'status': 'error', 'message': 'Task not found'};

      if (args.containsKey('title')) task.title = args['title'] as String;
      if (args.containsKey('difficulty')) task.difficulty = (args['difficulty'] as int);
      if (args.containsKey('isArchived')) task.isArchived = args['isArchived'] as bool;
      
      await taskRepository.update(task);
      return {'status': 'success', 'message': 'Task updated'};
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  /// Helper to delete tasks
  Future<Map<String, Object?>> _performDeleteTask(Map<String, Object?> args) async {
    try {
      final idRaw = args['id'];
      if (idRaw == null) return {'status': 'error', 'message': 'Task ID required'};
      final id = idRaw is int ? idRaw : int.parse(idRaw.toString());

      final success = await taskRepository.delete(id);
      return {'status': success ? 'success' : 'error', 'message': success ? 'Task deleted' : 'Delete failed'};
    } catch (e) {
      return {'status': 'error', 'message': e.toString()};
    }
  }

  String _buildSystemPrompt() {
    return '''
You are Arvion, a concise productivity assistant.
You have FULL CONTROL over tasks. Use tools to:
- `create_task`: Add new tasks.
- `list_tasks`: See what tasks exist (Check this first if user asks about "my tasks").
- `update_task`: Rename, change difficulty, or archive tasks.
- `delete_task`: Permanently remove tasks.

If the user asks to "complete" or "archive" a task, use `update_task` with `isArchived: true`.
Keep responses SHORT (1-2 sentences) unless listing items.
Format: Markdown. Tone: Minimalist & Direct.
''';
  }
}
