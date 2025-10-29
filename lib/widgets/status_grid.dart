import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../data/status_data.dart';

class StatusGrid extends StatelessWidget {
  final List<StatusItem> items; // List of status items to display

  const StatusGrid({super.key, required this.items});

  // Check if the media URL is a network path
  bool _isNetwork(String path) => path.startsWith('http');

  // Returns an image widget (network or asset) with fallback on error
  Widget _imageFor(StatusItem item, double height) {
    final img = _isNetwork(item.storyMediaUrl)
        ? Image.network(
            item.storyMediaUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: height,
            errorBuilder: (_, __, ___) => Container(
              height: height,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, size: 28),
            ),
          )
        : Image.asset(
            item.storyMediaUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: height,
            errorBuilder: (_, __, ___) => Container(
              height: height,
              color: Colors.grey[300],
              child: const Icon(Icons.broken_image, size: 28),
            ),
          );

    return img;
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2, // Two columns
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final item = items[i];

        // Alternate tile heights for staggered layout
        final double tileHeight = (i % 3 == 0) ? 260 : 170;

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Background image (asset or network)
              _imageFor(item, tileHeight),

              // Bottom gradient overlay for text readability
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 56,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black26,
                        Colors.black45,
                      ],
                    ),
                  ),
                ),
              ),

              // Avatar and username overlay
              Positioned(
                left: 8,
                bottom: 8,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage(item.thumbnailAsset),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 120, // Prevent text overflow
                      child: Text(
                        item.username.split(' ').first, // Show first name
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
