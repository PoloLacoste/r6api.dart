import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'singleton.dart';
import '../constants/constants.dart';
import '../models/responses/login.dart';

class AuthService {
  final Dio _client = Dio();

  final _storage = storage;
  final _urlService = urlService;

  Future<String?> login(String email, String password) async {
    final credentials = base64.encode(utf8.encode('$email:$password'));
    final token = 'Basic $credentials';
    try {
      final res = await _client.post<LoginResponse>(
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

      return res.data?.ticket;
    } catch (e) {
      print(e);
    }
  }
}
