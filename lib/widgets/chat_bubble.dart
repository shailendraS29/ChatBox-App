import 'package:flutter/material.dart';
import '../../models/chat_model.dart';
import '../../utils/app_colors.dart'; // ✅ Import your color system

class ChatBubble extends StatelessWidget {
  final ChatMessage message; // Message data (text or file)
  final bool isMe; // Whether the message is sent by current user

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    // Use centralized colors from AppColors
    final bubbleColor = isMe ? AppColors.bubbleMe : AppColors.bubbleOther;
    final textColor = isMe ? AppColors.textMe : AppColors.textOther;
    final iconColor = isMe ? AppColors.iconMe : AppColors.iconOther;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text message
            if (message.type == MessageType.text)
              Text(message.text, style: TextStyle(color: textColor)),

            // File message
            if (message.type == MessageType.file)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.insert_drive_file, size: 20, color: iconColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          message.fileName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.download_rounded, color: iconColor),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.fileDescription ?? '',
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),

            const SizedBox(height: 4),

            // Timestamp
            Text(
              '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(color: AppColors.timestamp, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
