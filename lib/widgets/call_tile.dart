import 'package:flutter/material.dart';
import '../models/call_model.dart';
import '../utils/app_colors.dart';

class CallTile extends StatelessWidget {
  final Call call;
  final VoidCallback? onTap;
  final VoidCallback? onCallAction;

  const CallTile({
    super.key,
    required this.call,
    this.onTap,
    this.onCallAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final callTypeIcon = call.isVideo ? Icons.videocam : Icons.call;
    final directionIcon = call.isIncoming
        ? Icons.call_received
        : Icons.call_made;
    final directionColor = call.isMissed ? Colors.red : AppColors.muted;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: AppColors.withOpacity(AppColors.primary, 0.08),
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.transparent,
            child: Row(
              children: [
                // Avatar
                SizedBox(
                  width: AppColors.avatarRadius * 2,
                  height: AppColors.avatarRadius * 2,
                  child: ClipOval(
                    child: Image.asset(
                      call.avatarAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.person,
                          size: AppColors.avatarRadius.toDouble(),
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Name and time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        call.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(directionIcon, size: 16, color: directionColor),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              call.time,
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Call icon
                InkWell(
                  onTap: onCallAction,
                  borderRadius: BorderRadius.circular(20),
                  splashColor: AppColors.withOpacity(AppColors.primary, 0.12),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: AppColors.dividerLight),
                    ),
                    child: Icon(
                      callTypeIcon,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Divider
        Container(
          height: 1,
          margin: const EdgeInsets.only(left: 72, right: 16),
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        ),
      ],
    );
  }
}
