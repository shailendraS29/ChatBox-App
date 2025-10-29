import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Static profile data
  static const _name = 'Shailendra S';
  static const _about = 'Available';
  static const _phone = '+91 843-XXXX-392';
  static const _email = 'shailendra.29sq@gmail.com';
  static const _avatarPath = 'assets/images/profile_photo.jpg';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark
        ? AppColors.dividerDark
        : AppColors.dividerLight;

    const double avatarSize = 120;
    const double titleSize = 20.0;
    const double subtitleSize = 14.0;
    const double rowIconSize = 22.0;
    const double chevronSize = 24.0;

    // Reusable contact row with optional chevron
    Widget contactRow(IconData icon, String text, {VoidCallback? onTap}) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.muted, size: rowIconSize),
              const SizedBox(width: 12),
              Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: AppColors.muted,
                  size: chevronSize,
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
        actions: [
          // Scan icon
          IconButton(
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Scan tapped'))),
            icon: Icon(
              Icons.qr_code_scanner,
              color: AppColors.primary,
              size: rowIconSize,
            ),
            tooltip: 'Scan',
          ),
          // More options icon
          IconButton(
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('More options'))),
            icon: Icon(
              Icons.more_vert,
              color: AppColors.primary,
              size: rowIconSize,
            ),
            tooltip: 'More',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // Avatar
            SizedBox(
              width: avatarSize,
              height: avatarSize,
              child: ClipOval(
                child: Image.asset(
                  _avatarPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.grey.shade300),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Name and about
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          _name,
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          _about,
                          style: TextStyle(
                            fontSize: subtitleSize,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.primary,
                      size: rowIconSize,
                    ),
                    tooltip: 'Edit',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Container(height: 1, color: dividerColor),

            // Contact rows
            contactRow(
              Icons.phone,
              _phone,
              onTap: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Dialer stub'))),
            ),
            Container(height: 1, color: dividerColor),
            contactRow(
              Icons.email,
              _email,
              onTap: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Email stub'))),
            ),
            Container(height: 1, color: dividerColor),
          ],
        ),
      ),
    );
  }
}
