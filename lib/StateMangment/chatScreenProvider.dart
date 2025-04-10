import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  final String _apiKey =
      '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'; // Use your actual key here
  final String _apiUrl = 'https://openrouter.ai/api/v1/chat/completions';

  final List<String> _messages = [];

  List<String> get messages => _messages;

  // Send message to the API
  Future<void> sendMessage(String message) async {
    _messages.add("You: $message");
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://your-website.com',
          'X-Title': 'Your Site Name',
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-r1-zero:free",
          "messages": [
            {"role": "user", "content": message}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final reply =
            decoded['choices'][0]['message']['content'] ?? '🤖 No response';
        _messages.add("AI: $reply");
        print("AI: $reply");
      } else {
        _messages.add(
            "AI: ❌ Error: ${response.statusCode} - ${response.reasonPhrase}");
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      _messages.add("AI: ⚠️ Exception: $e");
      print("Exception: $e");
    }

    notifyListeners();
  }
}
