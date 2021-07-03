import 'dart:convert';

import 'package:dio/dio.dart';

import 'singleton.dart';
import 'http_client.dart';
import '../constants/constants.dart';
import '../models/dtos/ubi_login_dto.dart';

class AuthService {
  final HttpClient _client = HttpClient();

  final _storage = storage;
  final _urlService = urlService;

  Future<String?> login(String email, String password) async {
    if (_storage.token != null) {
      return _storage.token;
    }

    final credentials = base64.encode(utf8.encode('$email:$password'));
    final token = 'Basic $credentials';
    try {
      final res = await _client.post<UbiLoginDto, UbiLoginDto>(
        _urlService.getLogin(),
        data: {
          'rememberMe': false,
        },
        options: Options(
          headers: {
            'Authorization': token,
            'Ubi-AppId': ubiAppId,
          },
          responseType: ResponseType.json,
        ),
      );
      final ticket = res.data?.ticket;
      if (ticket != null) {
        _storage.token = ticket;
      }
      return ticket;
    } catch (e) {
      print(e);
    }
  }
}
