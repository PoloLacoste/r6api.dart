import 'package:dio/dio.dart';

import '../models/dtos/dtos.dart';
import '../models/api_response.dart';
import '../constants/constants.dart';

typedef MapFactory<BodyType> = BodyType Function(Map<String, dynamic> map);

class HttpClient {
  HttpClient({BaseOptions? options, Iterable<Interceptor>? interceptors}) {
    _dio = Dio(
      options ??
          BaseOptions(
            receiveDataWhenStatusError: true,
            validateStatus: (status) => status! <= 500,
          ),
    )
      ..interceptors.addAll(interceptors ?? [])
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Ubi-Appid'] = ubiAppId;
          return handler.next(options);
        },
      ));
  }

  late final Dio _dio;

  static final _factories = <Type, MapFactory>{
    UbiLoginDto: UbiLoginDto.fromMapFactory,
    StatusDto: StatusDto.fromMapFactory,
    ProfileDto: ProfileDto.fromMapFactory,
    ProfilesDto: ProfilesDto.fromMapFactory,
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

  ApiResponse<BodyType> _convertApiResponse<BodyType, InnerType>(Response res,
      [bool noConversion = false]) {
    final data = noConversion ? res.data : _decode<InnerType>(res.data);
    String? error;
    if (data == null) {
      error = res.data;
    }
    return ApiResponse(
      data: data,
      success: res.statusCode == 200,
      error: error,
    );
  }

  Future<ApiResponse<BodyType>> get<BodyType, InnerType>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool noConversion = false,
  }) async {
    final res = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return _convertApiResponse<BodyType, InnerType>(res, noConversion);
  }

  Future<ApiResponse<BodyType>> post<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool noConversion = false,
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

    return _convertApiResponse<BodyType, InnerType>(res, noConversion);
  }

  Future<ApiResponse<BodyType>> put<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool noConversion = false,
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

    return _convertApiResponse<BodyType, InnerType>(res, noConversion);
  }

  Future<ApiResponse<BodyType>> patch<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool noConversion = false,
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

    return _convertApiResponse<BodyType, InnerType>(res, noConversion);
  }

  Future<ApiResponse<BodyType>> delete<BodyType, InnerType>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool noConversion = false,
  }) async {
    final res = await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    return _convertApiResponse<BodyType, InnerType>(res, noConversion);
  }
}
