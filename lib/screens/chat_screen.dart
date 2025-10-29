import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat_model.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_field.dart';

class ChatScreen extends StatelessWidget {
  final ChatUser user; // Chat participant info
  final List<ChatMessage> messages; // Full message list
  final String currentUserId; // ID of the current user

  const ChatScreen({
    super.key,
    required this.user,
    required this.messages,
    required this.currentUserId,
  });

  // Returns today's date in readable format
  String _getTodayDate() {
    return DateFormat('EEEE, MMM d').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final chatDate = _getTodayDate();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ChatHeader(user: user), // Custom header with avatar + name
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Center(
            child: Text(
              chatDate,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final msg = messages[i];
                final isMe = msg.senderId == currentUserId;
                return ChatBubble(message: msg, isMe: isMe); // Message bubble
              },
            ),
          ),
          const Divider(height: 1, color: Colors.black12),
          ChatInputField(onSend: (_) {}, onAttach: () {}), // Input field
        ],
      ),
    );
  }
}
