import 'profile_dto.dart';

class ProfilesDto {
  ProfilesDto({
    required this.profiles,
  });

  final List<ProfileDto?> profiles;

  static const fromMapFactory = _$fromMap;

  factory ProfilesDto.fromMap(Map<String, dynamic> map) {
    return ProfilesDto(
      profiles: List<ProfileDto?>.from(map['profiles']
          ?.where((x) => x != null)
          .map((x) => ProfileDto.fromMap(x))),
    );
  }
}

ProfilesDto _$fromMap(Map<String, dynamic> map) => ProfilesDto.fromMap(map);
