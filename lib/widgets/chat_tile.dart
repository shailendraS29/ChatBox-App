import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../utils/app_colors.dart';

class ChatTile extends StatefulWidget {
  final Chat chat; // Chat data model
  final VoidCallback? onTap; // Tap callback
  final VoidCallback? onLongPress; // Long press callback

  const ChatTile({super.key, required this.chat, this.onTap, this.onLongPress});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  double _scale = 1.0; // Used for tap animation

  void _setPressed(bool pressed) =>
      setState(() => _scale = pressed ? 0.97 : 1.0); // Scale down on press

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chat = widget.chat;

    return Column(
      children: [
        AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 120),
          child: InkWell(
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            onTapDown: (_) => _setPressed(true),
            onTapUp: (_) => _setPressed(false),
            onTapCancel: () => _setPressed(false),
            borderRadius: BorderRadius.circular(8),
            splashColor: AppColors.primary.withValues(alpha: 0.08 * 255),
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: AppColors.avatarRadius,
                    backgroundImage: chat.avatarAsset.isNotEmpty
                        ? AssetImage(chat.avatarAsset)
                        : null,
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 12),

                  // Name and last message
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chat.lastMessage,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Time and unread badge
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat.time,
                        style: TextStyle(fontSize: 12, color: AppColors.muted),
                      ),
                      const SizedBox(height: 6),
                      if (chat.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            chat.unreadCount > 99
                                ? '99+'
                                : chat.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Divider below each chat tile
        Divider(
          indent: 72,
          endIndent: 16,
          height: 1,
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ],
    );
  }
}
