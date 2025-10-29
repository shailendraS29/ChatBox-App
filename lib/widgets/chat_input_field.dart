import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final Function(String) onSend; // Callback when message is sent
  final VoidCallback onAttach; // Callback when attachment icon is tapped

  const ChatInputField({
    super.key,
    required this.onSend,
    required this.onAttach,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(); // Controls text input

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Attachment icon
          IconButton(
            onPressed: onAttach,
            icon: const Icon(Icons.add_circle, color: Colors.blue),
          ),

          // Text input field
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send icon
          IconButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onSend(controller.text.trim()); // Send message
                controller.clear(); // Clear input
              }
            },
            icon: const Icon(Icons.send, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
