// Message content type
enum MessageType { text, file }

class Chat {
  final String id; // Unique chat ID
  final String name; // Display name
  final String lastMessage; // Preview of last message
  final String time; // Timestamp string (e.g. "Yesterday, 5:30 PM")
  final String avatarAsset; // Path to avatar image
  final bool isOnline; // Online status
  final int unreadCount; // Number of unread messages

  const Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarAsset,
    required this.isOnline,
    this.unreadCount = 0,
  });
}

class ChatUser {
  final String id; // User ID
  final String name; // Display name
  final String avatarAsset; // Path to avatar image
  final bool isOnline; // Online status

  const ChatUser({
    required this.id,
    required this.name,
    required this.avatarAsset,
    required this.isOnline,
  });
}

class ChatMessage {
  final String id; // Unique message ID
  final String senderId; // Sender's user ID
  final String text; // Message text
  final DateTime timestamp; // When message was sent
  final MessageType type; // Text or file
  final String? fileName; // Optional file name
  final String? fileSize; // Optional file size
  final String? fileDescription; // Optional file description

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.type,
    this.fileName,
    this.fileSize,
    this.fileDescription,
  });
}
