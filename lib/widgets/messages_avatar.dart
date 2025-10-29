import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../utils/app_colors.dart';

class MessagesAvatar extends StatelessWidget {
  final List<Chat> users; // List of chat users to display
  final void Function(Chat)? onTap; // Callback when an avatar is tapped
  final String placeholderAsset; // Fallback image if avatar fails to load

  const MessagesAvatar({
    super.key,
    required this.users,
    this.onTap,
    this.placeholderAsset = 'assets/images/avatar_placeholder.png',
  });

  @override
  Widget build(BuildContext context) {
    final radius = AppColors.avatarStoryRadius; // Avatar radius from theme
    final diameter = radius * 2;

    return SizedBox(
      height: diameter + 28, // Total height including name label
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // Smooth horizontal scroll
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: users.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 12), // Space between avatars
        itemBuilder: (_, i) {
          final user = users[i];
          return GestureDetector(
            onTap: () => onTap?.call(user), // Trigger tap callback
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: radius,
                      backgroundImage: AssetImage(
                        user.avatarAsset,
                      ), // User avatar image
                      onBackgroundImageError:
                          (_, __) {}, // Prevent crash on image load fail
                      backgroundColor: Colors.grey[200],
                    ),
                    Positioned(
                      bottom: 3,
                      right: 3,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: user.isOnline
                              ? Colors.green
                              : Colors.red, // Online status indicator
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ), // White border ring
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  user.name.split(' ').first, // Show only first name
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
