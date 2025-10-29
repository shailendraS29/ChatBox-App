import 'package:flutter/material.dart';

class AppColors {
  // Primary brand color (modern blue)
  static const Color primary = Color(0xFF1A73E8);

  // Backgrounds
  static const Color bgLight = Color(0xFFF7F8FA);
  static const Color bgDark = Color(0xFF0B0E12);

  // Text / muted
  static const Color muted = Color(0xFF8A8F98);
  static const Color card = Colors.white;

  // Unread badge color (slightly softer)
  static const Color unread = Color(0xFF0F9D58);

  // Divider
  static const Color dividerLight = Color(0xFFE7E9EC);
  static const Color dividerDark = Color(0xFF1F2328);

  // Sizes
  static const double avatarRadius = 26; // chat list avatar radius
  static const double avatarStoryRadius = 40; // story avatar radius

  // Avatar gradients
  static const List<Color> radiantGradient = [
    Color(0xFFB2EBF2),
    Color(0xFF03A9F4),
    Color(0xFF0288D1),
    Color(0xFFB2EBF2),
  ];

  // Chat bubble colors
  static const Color bubbleMe = primary; // outgoing message bubble
  static const Color bubbleOther = Colors.white; // incoming message bubble

  // Chat text colors
  static const Color textMe = Colors.white;
  static const Color textOther = Colors.black87;

  // Chat icon colors
  static const Color iconMe = Colors.white;
  static const Color iconOther = Color(0xFF616161); // muted gray

  // Timestamp text
  static const Color timestamp = Color(0xFF9E9E9E); // light gray

  // Utility
  static Color withOpacity(Color base, double opacity) =>
      base.withValues(alpha: opacity * 255);
}
