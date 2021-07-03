class Profile {
  Profile({
    required this.id,
    required this.userId,
    required this.idOnPlatform,
    required this.platformType,
    required this.nameOnPlatform,
    required this.avatars,
  });

  final String id;
  final String userId;
  final String idOnPlatform;
  final String platformType;
  final String nameOnPlatform;
  final Map<int, String> avatars;
}
