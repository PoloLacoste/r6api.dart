import 'dart:convert';

import 'package:dio/dio.dart';
import '../constants/constants.dart';

import 'singleton.dart';

class AuthService {
  final Dio _client = Dio();

  final _storage = storage;
  final _urlService = urlService;

  Future<String?> login(String email, String password) async {
    final credentials = base64.encode(utf8.encode('$email:$password'));
    final token = 'Basic $credentials';
    try {
      final res = await _client.post(
        _urlService.getLogin(),
        data: {
          'rememberMe': true,
        },
        options: Options(
          headers: {
            'Authorization': token,
            'Ubi-AppId': ubiAppId,
          },
        ),
      );
      return res.data.ticket;
    } catch (e) {
      print(e);
    }
  }
}
