import 'package:ai_chatbot/const.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _openAi = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(receiveTimeout: Duration(seconds: 5)),
    enableLog: true,
  );
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
    setState(() {
      _messgaes.insert(0, m);
    });
    List<Messages> _messageHistory =
        _messgaes.reversed.map((m) {
          if (m.user == _currentUser) {
            return Messages(role: Role.user, content: m.text);
          } else {
            return Messages(role: Role.assistant, content: m.text);
          }
        }).toList();
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
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromRGBO(0, 166, 126, 1),
          textColor: Colors.white,
        ),
        onSend: (message) {
          getChatResponse(message);
        },
        messages: _messgaes,
      ),
    );
  }
}
