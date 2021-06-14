import 'dart:io' as io;

import 'package:dio/dio.dart';

import 'singleton.dart';
import 'http_client.dart';
import 'auth_service.dart';
import '../models/profile.dart';
import '../models/dtos/status_dto.dart';
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
                options.headers['Authorization'] = token;
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

  Future<Profile?> getById() async {
    print(
        await _client.get<List<StatusDto>, StatusDto>(_urlService.getStatus()));
  }

  Future<List<StatusDto>?> getStatus() async {
    final res =
        await _client.get<List<StatusDto>, StatusDto>(_urlService.getStatus());
    if (res.statusCode == io.HttpStatus.ok && res.data != null) {
      return res.data
          ?.where((el) =>
              el.name.contains('Rainbow Six Siege') &&
              platforms.contains(el.platform))
          .toList();
    }
    return null;
  }
}
