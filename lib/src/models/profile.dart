class Profile {
  Profile({
    required this.profileId,
    required this.userId,
    required this.idOnPlatform,
    required this.platformType,
    required this.nameOnPlatform,
    required this.avatars,
  });
  
  final String profileId;
  final String userId;
  final String idOnPlatform;
  final String platformType;
  final String nameOnPlatform;
  final Map<int, String> avatars;
}
