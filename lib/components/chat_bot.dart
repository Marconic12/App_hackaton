import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];

  final String _apiUrl = "https://api-inference.huggingface.co/models/gpt2";


  final String _apiToken =
      "Bearer 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";

  Future<void> _sendMessage(String text) async {
 
    setState(() {
      _messages.add({"role": "user", "content": text});
    });
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Authorization": _apiToken,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"inputs": text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final reply = data is List
            ? data[0]["generated_text"] ?? "No entendí la respuesta 😅"
            : data["generated_text"] ?? "No entendí la respuesta 😅";

        setState(() {
          _messages.add({"role": "bot", "content": reply});
        });
      } else {
        setState(() {
          _messages.add({
            "role": "bot",
            "content":
                "⚠️ Error en la solicitud (${response.statusCode}). Intenta de nuevo."
          });
        });
      }
    } catch (e) {
      print("Error enviando mensaje: $e");
      setState(() {
        _messages.add({
          "role": "bot",
          "content":
              "❌ Hubo un problema al enviar tu mensaje. Intenta de nuevo."
        });
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat con MaRo"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["role"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.purple[200]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["content"] ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Escribe tu mensaje...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color.fromARGB(255, 30, 38, 160)),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      _controller.clear();
                      _sendMessage(text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
