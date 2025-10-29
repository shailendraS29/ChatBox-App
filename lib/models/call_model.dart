class Call {
  final String name; // Contact name
  final String avatarAsset; // Path to avatar image
  final String time; // Formatted time string (e.g. "Today, 9:42 AM")
  final bool isIncoming; // true = incoming, false = outgoing
  final bool isMissed; // true = missed call
  final bool isVideo; // true = video call

  Call({
    required this.name,
    required this.avatarAsset,
    required this.time,
    this.isIncoming = true,
    this.isMissed = false,
    this.isVideo = false,
  });
}
