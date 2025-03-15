import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: "Arslan",
    lastName: "Yousaf",
  );
  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: "Chat",
    lastName: "GPT",
  );

  List<ChatMessage> _messgaes = <ChatMessage>[];

  Future<void> getChatResponse(ChatMessage m) async {
    debugPrint(m.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
        title: const Text("AI ChatBot", style: TextStyle(color: Colors.white)),
      ),
      body: DashChat(
        currentUser: _currentUser,
        onSend: (message) {
          getChatResponse(message);
        },
        messages: _messgaes,
      ),
    );
  }
}
