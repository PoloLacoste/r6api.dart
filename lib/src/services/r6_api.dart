import 'package:dio/dio.dart';

import 'singleton.dart';
import 'auth_service.dart';
import '../models/profile.dart';

class R6Api {
  R6Api({
    required this.email,
    required this.password,
  }) {
    _ignoredPath.add(_urlService.getStatus());

    _client = Dio()
      ..interceptors.add(
        InterceptorsWrapper(onRequest: (options, handler) async {
          if (!_ignoredPath.contains(options.uri.path)) {
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
        }),
      );
  }

  final _urlService = urlService;
  final _authService = AuthService();
  final List<String> _ignoredPath = [];
  late Dio _client;

  final String email;
  final String password;

  Future<Profile?> getById() async {
    print(await _client.get(_urlService.getStatus()));
  }
}
