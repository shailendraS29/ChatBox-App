// status_data.dart

class StatusItem {
  final String username;
  final String thumbnailAsset; // for avatar
  final String storyMediaUrl; // for grid image/GIF

  const StatusItem({
    required this.username,
    required this.thumbnailAsset,
    required this.storyMediaUrl,
  });

  bool get isUserStory => username.isNotEmpty;
}

// 🔹 User stories (avatars + media)
final List<StatusItem> statusItems = [
  StatusItem(
    username: 'Shilpa',
    thumbnailAsset: 'assets/images/user4.jpg',
    storyMediaUrl: 'assets/stories/story_8.gif',
  ),
  StatusItem(
    username: 'Nitish Shetty',
    thumbnailAsset: 'assets/images/user10.jpg',
    storyMediaUrl: 'assets/stories/story_2.jpg',
  ),
  StatusItem(
    username: 'Rohit',
    thumbnailAsset: 'assets/images/user3.jpg',
    storyMediaUrl: 'assets/stories/story_1.jpg',
  ),
  StatusItem(
    username: 'Smruthi GM',
    thumbnailAsset: 'assets/images/user5.jpg',
    storyMediaUrl: 'assets/stories/story_3.jpg',
  ),
  StatusItem(
    username: 'Abhishek',
    thumbnailAsset: 'assets/images/user1.jpg',
    storyMediaUrl: 'assets/stories/story_10.gif',
  ),
  StatusItem(
    username: 'Disha S',
    thumbnailAsset: 'assets/images/user8.jpg',
    storyMediaUrl: 'assets/stories/story_4.jpg',
  ),
  StatusItem(
    username: 'Asha Sharma',
    thumbnailAsset: 'assets/images/user2.jpg',
    storyMediaUrl: 'assets/stories/story_5.jpg',
  ),
  StatusItem(
    username: 'Sachin dubey',
    thumbnailAsset: 'assets/images/user6.jpg',
    storyMediaUrl: 'assets/stories/story_9.gif',
  ),
  StatusItem(
    username: 'Friends 4ever',
    thumbnailAsset: 'assets/images/user7.jpg',
    storyMediaUrl: 'assets/stories/story_6.jpg',
  ),
  StatusItem(
    username: 'Techmates',
    thumbnailAsset: 'assets/images/user9.jpg',
    storyMediaUrl: 'assets/stories/story_7.jpg',
  ),
];
