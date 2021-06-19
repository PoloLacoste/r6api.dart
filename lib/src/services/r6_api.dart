import 'package:dio/dio.dart';

import 'singleton.dart';
import 'http_client.dart';
import 'auth_service.dart';
import '../models/profile.dart';
import '../models/playtime.dart';
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

  Future<Playtime?> getPlaytime(Platform platform, String id) async {
    final res = await _client.get(_urlService.getPlaytime(platform, [id]),
        noConversion: true);
    if (res.success && res.data != null) {
      final data = res.data['results']?[id];
      if (data != null) {
        final generalPvp = _statGetter(data, 'general', 'pvp');
        final rankedPvp = _statGetter(data, 'ranked', 'pvp');
        final casualPvp = _statGetter(data, 'casual', 'pvp');
        final customPvp = _statGetter(data, 'custom', 'pvp');

        return Playtime(
          id: id,
          pvp: Pvp(
            general: generalPvp,
            ranked: rankedPvp,
            casual: casualPvp,
            custom: customPvp,
            other: generalPvp - (rankedPvp + casualPvp - customPvp),
          ),
          pve: Pve(
            general: _statGetter(data, 'general', 'pve'),
          ),
        );
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

  int _statGetter(dynamic data, String stat, String type) {
    return data['$stat${type}_timeplayed:infinite'] ?? 0;
  }
}
