import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final String apiKey =
        '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'; // Use your API key here.

    if (_controller.text.isEmpty) return;

    // Add the user's message to the chat
    setState(() {
      _messages.add(ChatMessage(
        text: _controller.text,
        isUser: true,
      ));
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      // Make the API call
      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://your-app.com', // Replace with your site URL
          'X-Title': 'Your App Name', // Replace with your app title
        },
        body: jsonEncode({
          'model': 'deepseek/deepseek-r1-zero:free', // Model to use
          'messages': [
            {
              'role': 'system',
              'content':
                  'Respond in clear, simple text. Avoid LaTeX formatting.'
            },
            {
              'role': 'user',
              'content': _messages.last.text
            }, // Sending user's last message
          ],
        }),
      );

      // Check if response status is OK (200)
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final content = decoded['choices'][0]['message']['content'];

        // Clean up content if necessary (e.g., removing LaTeX-style formatting)
        final cleanContent = content
            .replaceAll(r'\boxed{', '')
            .replaceAll('}', '')
            .replaceAll(r'\frac', '')
            .replaceAll(r'\sqrt', '√');

        // Add the chatbot's response to the chat
        setState(() {
          _messages.add(ChatMessage(
            text: cleanContent,
            isUser: false,
          ));
        });
      } else {
        setState(() {
          _messages.add(ChatMessage(
            text: 'Error: ${response.statusCode}',
            isUser: false,
          ));
        });
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'Error: $e',
          isUser: false,
        ));
      });
      print('Error: $e');
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          if (_isLoading) LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              child: Text('AI'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          SizedBox(width: 10),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          if (isUser) SizedBox(width: 10),
          if (isUser)
            CircleAvatar(
              child: Icon(Icons.person),
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
            ),
        ],
      ),
    );
  }
}
