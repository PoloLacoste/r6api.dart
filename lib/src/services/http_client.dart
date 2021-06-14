import 'package:dio/dio.dart';

import '../models/dtos/ubi_login_dto.dart';
import '../models/dtos/status_dto.dart';

typedef MapFactory<BodyType> = BodyType Function(Map<String, dynamic> map);

class HttpClient {
  HttpClient({BaseOptions? options, Iterable<Interceptor>? interceptors}) {
    _dio = Dio(options)..interceptors.addAll(interceptors ?? []);
  }

  late final Dio _dio;

  static final _factories = <Type, MapFactory>{
    UbiLoginDto: UbiLoginDto.fromMapFactory,
    StatusDto: StatusDto.fromMapFactory,
  };

  BodyType? _decodeMap<BodyType>(Map<String, dynamic> values) {
    final mapFactory = _factories[BodyType];
    if (mapFactory != null && mapFactory is MapFactory<BodyType>) {
      return mapFactory(values);
    }

    return null;
  }

  List<BodyType> _decodeList<BodyType>(List values) => values
      .where((v) => v != null)
      .map<BodyType>((v) => _decode<BodyType>(v))
      .toList();

  dynamic _decode<BodyType>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<BodyType>(entity as List);
    }

    if (entity is Map) {
      return _decodeMap<BodyType>(entity as Map<String, dynamic>);
    }

    return entity;
  }

  Response<BodyType> _convertResponse<BodyType, InnerType>(Response res) {
    return Response<BodyType>(
      data: _decode<InnerType>(res.data),
      headers: res.headers,
      requestOptions: res.requestOptions,
      isRedirect: res.isRedirect,
      statusCode: res.statusCode,
      statusMessage: res.statusMessage,
      redirects: res.redirects,
      extra: res.extra,
    );
  }

  Future<Response<BodyType>> get<BodyType, InnerType>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return _convertResponse<BodyType, InnerType>(res);
  }

  Future<Response<BodyType>> post<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _convertResponse<BodyType, InnerType>(res);
  }

  Future<Response<BodyType>> put<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _convertResponse<BodyType, InnerType>(res);
  }

  Future<Response<BodyType>> patch<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final res = await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _convertResponse<BodyType, InnerType>(res);
  }

  Future<Response<BodyType>> delete<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final res = await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    return _convertResponse<BodyType, InnerType>(res);
  }
}
