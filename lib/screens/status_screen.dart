import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/story_avatar.dart';
import '../widgets/status_grid.dart';
import '../widgets/search_bar.dart';
import '../data/status_data.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double avatarDiameter = AppColors.avatarStoryRadius * 2;
    final double itemWidth = avatarDiameter;

    return Scaffold(
      appBar: const _ExploreAppBar(), // Custom header
      body: Column(
        children: [
          const SizedBox(height: 8),
          const CustomSearchBar(hint: 'Search stories...'),
          const SizedBox(height: 12),

          // Horizontal story avatars
          SizedBox(
            height: avatarDiameter + 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: statusItems.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (ctx, idx) {
                if (idx == 0) {
                  return SizedBox(
                    width: itemWidth,
                    child: AddStoryAvatar(
                      onTap: () => _showSnack(context, 'Add Story'),
                    ),
                  );
                }

                final item = statusItems[idx - 1];
                return SizedBox(
                  width: itemWidth,
                  child: StoryAvatar(
                    imageAsset: item.thumbnailAsset,
                    label: item.username.split(' ').first,
                    isNew: true,
                    onTap: () => _showSnack(context, 'Story: ${item.username}'),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),
          Divider(
            height: 1,
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),

          // Staggered grid of story tiles
          Expanded(child: StatusGrid(items: statusItems)),
        ],
      ),
    );
  }

  // Show feedback via snackbar
  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _ExploreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ExploreAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            // Title
            Text(
              'Explore',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const Spacer(),

            // Camera icon
            _iconBtn(context, Icons.camera_alt_outlined, 'Camera'),

            // More options icon
            _iconBtn(context, Icons.more_vert, 'More'),
          ],
        ),
      ),
    );
  }

  // Reusable icon button with snackbar
  Widget _iconBtn(BuildContext ctx, IconData icon, String label) {
    return IconButton(
      onPressed: () => ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(SnackBar(content: Text(label))),
      icon: Icon(icon, color: AppColors.primary),
      tooltip: label,
    );
  }
}
