import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Modern bottom bar with centered FAB notch and labels
class CustomBottomBar extends StatelessWidget {
  final int currentIndex; // Currently selected tab index
  final ValueChanged<int> onTap; // Callback when a tab is tapped

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(), // Notch for FAB
      elevation: 2,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.chat_bubble_outline, 'Messages', 0),
            _buildNavItem(Icons.circle_outlined, 'Status', 1),
            const SizedBox(width: 48), // Spacer for FAB notch
            _buildNavItem(Icons.phone_rounded, 'Calls', 2),
            _buildNavItem(Icons.person_outline, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  // Builds individual nav item with icon and label
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    final color = isActive ? AppColors.primary : AppColors.muted;

    return GestureDetector(
      onTap: () => onTap(index), // Trigger tab change
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
