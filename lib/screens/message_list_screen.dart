import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/search_bar.dart';
import '../widgets/chat_tile.dart';
import '../widgets/messages_avatar.dart';
import '../screens/chat_screen.dart';
import '../models/chat_model.dart';
import '../utils/app_colors.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  String _searchQuery = ''; // Current search input

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();
    final chats = _searchQuery.isEmpty
        ? provider.chats
        : provider.search(_searchQuery); // Filtered chat list

    return Scaffold(
      appBar: const _CustomAppBar(), // Custom header
      body: Column(
        children: [
          const SizedBox(height: 8),
          CustomSearchBar(
            onChanged: (val) => setState(() => _searchQuery = val),
            hint: 'Search messages, contacts...',
          ),
          const SizedBox(height: 12),

          // Top action row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                _buildTextAction('New Group', () {
                  _showSnack(context, 'New Group tapped');
                }),
                const Spacer(),
                _buildTextAction('Archive (4)', () {
                  _showSnack(context, 'Archive tapped');
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Horizontal avatar list
          MessagesAvatar(
            users: provider.chats,
            onTap: (chat) {
              final user = ChatUser(
                id: chat.id,
                name: chat.name,
                avatarAsset: chat.avatarAsset,
                isOnline: chat.isOnline,
              );
              _openChat(
                context,
                user,
                provider.getMessages(chat.id),
                provider.currentUserId,
              );
            },
          ),

          // Vertical chat list
          Expanded(
            child: ListView.builder(
              key: ValueKey('${chats.length}$_searchQuery'),
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (ctx, i) {
                final chat = chats[i];
                return ChatTile(
                  key: ValueKey(chat.id),
                  chat: chat,
                  onTap: () {
                    final user = ChatUser(
                      id: chat.id,
                      name: chat.name,
                      avatarAsset: chat.avatarAsset,
                      isOnline: chat.isOnline,
                    );
                    _openChat(
                      context,
                      user,
                      provider.getMessages(chat.id),
                      provider.currentUserId,
                    );
                  },
                  onLongPress: () => _showQuickActions(context, chat),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Navigate to chat screen
  void _openChat(
    BuildContext context,
    ChatUser user,
    List<ChatMessage> messages,
    String currentUserId,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          user: user,
          messages: messages,
          currentUserId: currentUserId,
        ),
      ),
    );
  }

  // Show feedback via snackbar
  void _showSnack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  // Show bottom sheet with quick actions
  void _showQuickActions(BuildContext context, Chat chat) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Wrap(
        children: [
          _buildActionTile(Icons.volume_off_outlined, 'Mute', context),
          _buildActionTile(Icons.archive_outlined, 'Archive', context),
          _buildActionTile(
            Icons.delete_outline,
            'Delete',
            context,
            color: Colors.red,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Build bottom sheet action tile
  ListTile _buildActionTile(
    IconData icon,
    String title,
    BuildContext context, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color ?? Theme.of(context).iconTheme.color),
      ),
      onTap: () {
        Navigator.pop(context);
        _showSnack(context, '$title tapped');
      },
    );
  }

  // Build tappable text action
  Widget _buildTextAction(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Title
            Text(
              'Message',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const Spacer(),

            // Create post icon
            IconButton(
              onPressed: () => _showSnack(context, 'Add note tapped'),
              icon: Icon(Icons.post_add, color: AppColors.primary),
              tooltip: 'Create post',
            ),

            // More options icon
            IconButton(
              onPressed: () => _showSnack(context, 'More options tapped'),
              icon: Icon(Icons.more_vert, color: AppColors.primary),
              tooltip: 'More',
            ),
          ],
        ),
      ),
    );
  }

  static void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
