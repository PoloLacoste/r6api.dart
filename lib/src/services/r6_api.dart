import 'package:dio/dio.dart';

import 'singleton.dart';
import 'http_client.dart';
import 'auth_service.dart';
import '../models/profile.dart';
import '../models/dtos/dtos.dart';
import '../constants/constants.dart';

class R6Api {
  R6Api({
    required this.email,
    required this.password,
  }) {
    _ignoredPath.add(_urlService.getStatus());

    _client = HttpClient(
      interceptors: [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            if (!_ignoredPath.contains(options.path)) {
              final token = await _authService.login(email, password);
              if (token == null) {
                return handler.reject(DioError(
                  requestOptions: options,
                  error: 'Unauthenticated',
                ));
              } else {
                options.headers['Authorization'] = 'Ubi_v1 t=$token';
              }
            }
            return handler.next(options);
          },
        ),
      ],
    );
  }

  final _urlService = urlService;
  final _authService = AuthService();
  final List<String> _ignoredPath = [];
  late HttpClient _client;

  final String email;
  final String password;

  Future<Profile?> getByUsername(Platform platform, String username) async {
    final res = await _client.get<ProfilesDto, ProfilesDto>(
        _urlService.getByUsername(platform, [username]));
    if (res.success && res.data != null) {
      final profiles = res.data?.profiles ?? [];
      if (profiles.isNotEmpty && profiles.first != null) {
        return _getProfile(profiles.first!);
      }
    }
    return null;
  }

  Future<Profile?> getById(Platform platform, String id) async {
    final res = await _client.get<ProfilesDto, ProfilesDto>(
        _urlService.getByIdOnPlatform(platform, [id]));
    if (res.success && res.data != null) {
      final profiles = res.data?.profiles ?? [];
      if (profiles.isNotEmpty && profiles.first != null) {
        return _getProfile(profiles.first!);
      }
    }
    return null;
  }

  Future<List<StatusDto>?> getStatus() async {
    final res =
        await _client.get<List<StatusDto>, StatusDto>(_urlService.getStatus());
    if (res.success) {
      return res.data
          ?.where((el) =>
              el.name.contains('Rainbow Six Siege') &&
              platforms.contains(el.platform))
          .toList();
    }
    return null;
  }

  Profile _getProfile(ProfileDto profile) {
    return Profile(
      id: profile.profileId,
      userId: profile.userId,
      idOnPlatform: profile.idOnPlatform,
      platformType: profile.platformType,
      nameOnPlatform: profile.nameOnPlatform,
      avatars: _urlService.getAvatars(profile.userId),
    );
  }
}
