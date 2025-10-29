// Type of grid block: user story or media tile
enum GridBlockType { userStory, media }

class GridBlock {
  final GridBlockType type; // Block type
  final String imageUrl; // Background or media image
  final String? username; // Optional username (for story blocks)
  final String? avatarAsset; // Optional avatar (for story blocks)

  const GridBlock({
    required this.type,
    required this.imageUrl,
    this.username,
    this.avatarAsset,
  });
}
