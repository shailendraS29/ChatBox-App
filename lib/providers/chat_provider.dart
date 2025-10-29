import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../data/dummy_chats.dart';

class ChatProvider extends ChangeNotifier {
  // Internal list of chats (initially from dummy data)
  final List<Chat> _chats = List<Chat>.from(dummyChats);

  // Simulated current user ID
  final String _currentUserId = 'u2';

  // Read-only view for external consumers
  List<Chat> get chats => List.unmodifiable(_chats);

  String get currentUserId => _currentUserId;

  // Returns message history for a given chat ID
  List<ChatMessage> getMessages(String chatId) {
    return chatHistory[chatId] ?? [];
  }

  // Returns chats filtered by query (case-insensitive on name & lastMessage)
  List<Chat> search(String query) {
    if (query.isEmpty) return chats;
    final q = query.toLowerCase();
    return _chats.where((c) {
      return c.name.toLowerCase().contains(q) ||
          c.lastMessage.toLowerCase().contains(q);
    }).toList();
  }

  // Adds a new chat to the top of the list
  void addChat(Chat chat) {
    _chats.insert(0, chat);
    notifyListeners();
  }

  // Marks a chat as read by setting unreadCount to 0
  void markAsRead(String chatId) {
    final idx = _chats.indexWhere((c) => c.id == chatId);
    if (idx != -1) {
      final old = _chats[idx];
      _chats[idx] = Chat(
        id: old.id,
        name: old.name,
        lastMessage: old.lastMessage,
        time: old.time,
        avatarAsset: old.avatarAsset,
        unreadCount: 0,
        isOnline: old.isOnline,
      );
      notifyListeners();
    }
  }
}
