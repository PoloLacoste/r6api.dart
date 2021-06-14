class ProfileDto {
  ProfileDto({
    required this.profileId,
    required this.userId,
    required this.idOnPlatform,
    required this.platformType,
    required this.nameOnPlatform,
  });

  final String profileId;
  final String userId;
  final String idOnPlatform;
  final String platformType;
  final String nameOnPlatform;

  static const fromMapFactory = _$fromMap;

  factory ProfileDto.fromMap(Map<String, dynamic> map) {
    return ProfileDto(
      profileId: map['profileId'],
      userId: map['userId'],
      idOnPlatform: map['idOnPlatform'],
      platformType: map['platformType'],
      nameOnPlatform: map['nameOnPlatform'],
    );
  }
}

ProfileDto _$fromMap(Map<String, dynamic> map) => ProfileDto.fromMap(map);
