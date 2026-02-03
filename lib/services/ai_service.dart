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
        tools: [_createTaskTool],
        generationConfig: GenerationConfig(
          temperature: 0.7,
          maxOutputTokens: 512,
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
        
        if (functionCall.name == 'create_task') {
          // 1. Notify UI (optional streaming update)
          yield "🛠️ Creating task: ${functionCall.args['title']}...";

          // 2. Execute Action
          final result = await _performCreateTask(functionCall.args);

          // 3. Send result back to model
          response = await chat.sendMessage(
            Content.functionResponse(functionCall.name, result),
          );
        }
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

  String _buildSystemPrompt() {
    return '''
You are Arvion, a concise productivity assistant.
You have the ability to CREATE tasks directly using the `create_task` tool.
If the user asks to "add", "create", or "remind" them of a task, CALL THE FUNCTION.

Your responses must be short (1-2 sentences) and to the point.
Format: Markdown. Tone: Minimalist & Direct.
''';
  }
}
