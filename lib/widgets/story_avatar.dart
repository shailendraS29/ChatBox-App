import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Gradient ring used for new story indicator
const SweepGradient _storyRingGradient = SweepGradient(
  colors: [Color(0xFF3A8DFF), Color(0xFF6BCBFF), Color(0xFF3A8DFF)],
  startAngle: 0,
  endAngle: 3.14159 * 2,
);

/// Diameter of avatar based on app theme radius
double get _avatarDiameter => AppColors.avatarStoryRadius * 2;

/// Widget for displaying a user's story avatar
class StoryAvatar extends StatefulWidget {
  final String imageAsset; // Path to avatar image
  final String label; // Name below avatar
  final bool isNew; // Whether to show gradient ring
  final VoidCallback? onTap; // Tap callback

  const StoryAvatar({
    super.key,
    required this.imageAsset,
    required this.label,
    this.isNew = false,
    this.onTap,
  });

  @override
  State<StoryAvatar> createState() => _StoryAvatarState();
}

class _StoryAvatarState extends State<StoryAvatar> {
  double _scale = 1.0; // Used for tap animation

  void _setScale(double v) => setState(() => _scale = v);

  @override
  Widget build(BuildContext context) {
    final double size = _avatarDiameter;
    final double inner = size - 12;

    // Use placeholder if imageAsset is empty
    final image = widget.imageAsset.isNotEmpty
        ? AssetImage(widget.imageAsset)
        : const AssetImage('assets/images/avatar_placeholder.png');

    return SizedBox(
      width: size + 8,
      child: Column(
        children: [
          GestureDetector(
            onTapDown: (_) => _setScale(0.96),
            onTapUp: (_) {
              _setScale(1.0);
              widget.onTap?.call(); // Trigger tap callback
            },
            onTapCancel: () => _setScale(1.0),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 120),
              scale: _scale,
              child: Container(
                width: size,
                height: size,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: widget.isNew
                      ? _storyRingGradient
                      : null, // Show ring if new
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: Image(
                      image: image,
                      width: inner,
                      height: inner,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: inner,
                        height: inner,
                        color: Colors.grey[200],
                        child: Icon(Icons.person, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying "Add Story" avatar with plus badge
class AddStoryAvatar extends StatelessWidget {
  final VoidCallback? onTap; // Tap callback
  final String label;

  const AddStoryAvatar({super.key, this.onTap, this.label = 'Your Story'});

  @override
  Widget build(BuildContext context) {
    final double size = _avatarDiameter;
    final double inner = size - 12;
    final double badge = size * 0.36; // Size of plus badge

    return SizedBox(
      width: size + 8,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: size,
                  height: size,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _storyRingGradient, // Always show ring
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Container(
                        width: inner,
                        height: inner,
                        color: Colors.grey[100],
                        child: Center(
                          child: Icon(
                            Icons.person_outline,
                            size: inner * 0.44,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: badge,
                  height: badge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _storyRingGradient,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(58, 141, 255, 0.18),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: badge * 0.68,
                      height: badge * 0.68,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add_rounded,
                          size: badge * 0.36,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
