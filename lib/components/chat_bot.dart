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
  
  // RUTA LOCAL (ASSET): Ahora apunta a la ruta dentro de tu proyecto.
  
  final String _botAssetPath = "assets/icons/boton de chatbot.png"; 

  // La lista de mensajes comienza vacía, como solicitaste.
  final List<Map<String, String>> _messages = [];

  final String _apiUrl = "https://api-inference.huggingface.co/models/gpt2";

  final String _apiToken =
      "Bearer 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";

  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.add({"role": "user", "content": text});
    });
    _scrollToBottom();

    // Simulación de respuesta para el ejemplo visual si la API falla o es lenta
    if (text.toLowerCase().contains("ajuste")) {
      setState(() {
        _messages.add({"role": "bot", "content": "Entendido. ¿Qué hora deseas para el Desayuno?"});
      });
       _scrollToBottom();
       return;
    }


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

        // Filtramos para obtener solo la respuesta del bot si el modelo GPT2 devuelve todo el historial
        final filteredReply = reply.split(text).last.trim();

        setState(() {
          _messages.add({"role": "bot", "content": filteredReply});
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
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nuevo color de fondo del chat: #5fe1f7
    const Color chatBackgroundColor = Color(0xFF5fe1f7); 
    
    // Colores de burbuja
    const Color userBubbleColor = Color.fromARGB(255, 60, 140, 255); // Azul fuerte
    const Color botBubbleColor = Colors.white; // Fondo blanco para el bot

    return Scaffold(
      // 1. Color de fondo del chat
      backgroundColor: chatBackgroundColor, 
      
      appBar: AppBar(
        // 2. Avatar en el AppBar
        title: Row(
          children: [
            CircleAvatar(
              // *** Usar AssetImage para la ruta local ***
              backgroundImage: AssetImage(_botAssetPath),
              radius: 18,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mari", 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Text(
                  "En línea | Asistente Nutricional", // Información adicional
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false, 
        backgroundColor: Colors.white, 
        elevation: 1, 
        leading: const BackButton(color: Colors.black), 
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
                
                // Widget del Mensaje con o sin Avatar
                Widget messageBubble = Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7, // Limitar ancho
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isUser ? userBubbleColor : botBubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(isUser ? 12 : 4), 
                      bottomRight: Radius.circular(isUser ? 4 : 12),
                    ),
                    boxShadow: [ 
                      if (!isUser) 
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                    ],
                  ),
                  child: Text(
                    message["content"] ?? "",
                    style: TextStyle(
                      fontSize: 15,
                      color: isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                );

                // 3. Mostrar el avatar solo en los mensajes del bot
                if (!isUser) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                        child: CircleAvatar(
                          // *** Usar AssetImage para la ruta local ***
                          backgroundImage: AssetImage(_botAssetPath),
                          radius: 12,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                      messageBubble,
                    ],
                  );
                }

                // Mensajes de Usuario
                return Align(
                  alignment: Alignment.centerRight,
                  child: messageBubble,
                );
              },
            ),
          ),
          // Barra de entrada de texto
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Escribe tu mensaje...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 60, 140, 255),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        _controller.clear();
                        _sendMessage(text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
