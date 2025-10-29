import 'package:flutter/material.dart';
import '../../models/chat_model.dart';

class ChatHeader extends StatelessWidget {
  final ChatUser user; // Chat user info (name, avatar, online status)

  const ChatHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            // Back button (navigates to previous screen)
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Back',
            ),

            // User avatar
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(user.avatarAsset),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 12),

            // User name and online status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  user.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const Spacer(),

            // Video and call action buttons (non-functional placeholders)
            IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          ],
        ),
      ),
    );
  }
}
