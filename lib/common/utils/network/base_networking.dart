import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/common/utils/logging/common_log.dart';

class BaseNetworking {
  static BaseNetworking shared = BaseNetworking();
  static Dio dio = Dio();

  ///[NOTES-MANDATORY] put your base_url here
  ///MAKE SURE you put `/` in end of variable value below
  static const baseAppUrl = 'https://testing.sulapaeppastudio.com/api/';

  static const Map<String, String> emptyMap = {};

  Future<Response> get({
    required String partUrl,
    String? baseUrl,
    String contentType = "application/json",
    Map<String, String> headers = emptyMap,
    Map<String, dynamic> queryParams = emptyMap,
  }) async {
    final usedHeaders = await getHeaders(contentType: contentType);
    usedHeaders.addAll(headers);

    dio.options.headers = usedHeaders;
    dio.options.baseUrl = baseUrl ?? baseAppUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 160000);
    dio.options.receiveTimeout = const Duration(milliseconds: 155000);
    dio.options.queryParameters = queryParams;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.reject(e);
        },
      ),
    );

    Log.debug(
      "$runtimeType GET_PROCESS ${dio.options.baseUrl}$partUrl queryParams ==> $queryParams",
    );
    Log.debug("$runtimeType GET_PROCESS WITH HEADER ${dio.options.headers}");

    var response = await dio.request(partUrl, options: Options(method: 'GET'));

    Log.debug("$runtimeType GET_PROCESS $partUrl response ==> $response");

    return response;
  }

  Future<Response> delete({
    required String partUrl,
    String? baseUrl,
    String contentType = "application/form-data",
    Map<String, String> headers = emptyMap,
    Map<String, dynamic> queryParams = emptyMap,
  }) async {
    final usedHeaders = await getHeaders(contentType: contentType);
    usedHeaders.addAll(headers);

    dio.options.headers = usedHeaders;
    dio.options.baseUrl = baseUrl ?? baseAppUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 160000);
    dio.options.receiveTimeout = const Duration(milliseconds: 155000);
    dio.options.queryParameters = queryParams;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.reject(e);
        },
      ),
    );

    var response = await dio.request(
      partUrl,
      options: Options(method: 'DELETE'),
    );

    Log.debug(
      "$runtimeType DELETE_PROCESS ${dio.options.baseUrl}$partUrl response ==> $response",
    );

    return response;
  }

  Future<Response> post<T>({
    required String partUrl,
    String? baseUrl,
    String contentType = "application/form-data",
    Map<String, String> headers = emptyMap,
    Map<String, dynamic> queryParams = emptyMap,
    Map<String, dynamic>? bodyParams,
    bool? isRawData = false,
    Function(int, int)? onSendProgress,
    dynamic data,
  }) async {
    final usedHeaders = await getHeaders(contentType: contentType);
    usedHeaders.addAll(headers);

    dio.options.baseUrl = baseUrl ?? baseAppUrl;
    dio.options.headers = usedHeaders;
    dio.options.connectTimeout = const Duration(milliseconds: 160000);
    dio.options.receiveTimeout = const Duration(milliseconds: 155000);
    dio.options.queryParameters = queryParams;

    dynamic formData;

    Log.debug(
      "$runtimeType url => ${dio.options.baseUrl}$partUrl , bodyParam before converting => $bodyParams",
    );
    if (isRawData ?? false) {
      Log.debug(
        "$runtimeType url => ${dio.options.baseUrl}$partUrl , rawData is ${bodyParams.runtimeType} => $bodyParams",
      );
    } else if (data != null) {
      Log.debug(
        "$runtimeType url => ${dio.options.baseUrl}$partUrl , data is ${data.runtimeType} => $data",
      );
    } else if (contentType == "application/json") {
      formData = bodyParams ?? data;
    } else {
      formData = FormData.fromMap(bodyParams ?? {});

      Log.debug(
        "url => ${dio.options.baseUrl}$partUrl , formData fields => ${formData.fields}, "
        "formData files => ${formData.files},",
      );
    }

    var response = await dio.fetch<Map<String, dynamic>>(
      _setStreamType<T>(
        Options(
          method: 'POST',
          headers: usedHeaders,
          followRedirects: false,
        ).compose(
          dio.options,
          partUrl,
          queryParameters: queryParams,
          data: isRawData ?? false ? bodyParams : data ?? formData,
          onSendProgress: onSendProgress,
        ),
      ).copyWith(baseUrl: dio.options.baseUrl),
    );

    Log.debug("$runtimeType POST_PROCESS $partUrl response ==> $response");

    return response;
  }

  Future<Response> put<T>({
    required String partUrl,
    String? baseUrl,
    String contentType = "application/form-data",
    Map<String, String> headers = emptyMap,
    Map<String, dynamic> queryParams = emptyMap,
    Map<String, dynamic>? bodyParams,
  }) async {
    final usedHeaders = await getHeaders(contentType: contentType);
    usedHeaders.addAll(headers);

    dio.options.headers = usedHeaders;
    dio.options.baseUrl = baseUrl ?? baseAppUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 160000);
    dio.options.receiveTimeout = const Duration(milliseconds: 155000);
    dio.options.queryParameters = queryParams;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.reject(e);
        },
      ),
    );

    var body = json.encode(bodyParams);

    var response = await dio.fetch<Map<String, dynamic>>(
      _setStreamType<T>(
        Options(
          method: 'PUT',
          headers: usedHeaders,
          followRedirects: false,
        ).compose(
          dio.options,
          partUrl,
          queryParameters: queryParams,
          data: bodyParams,
        ),
      ).copyWith(baseUrl: dio.options.baseUrl, data: body),
    );

    Log.debug(
      "$runtimeType PUT_PROCESS ${dio.options.baseUrl}$partUrl response ==> $response",
    );

    return response;
  }

  Future<Map<String, dynamic>> getHeaders({
    String contentType = "application/json",
  }) async {
    Map<String, dynamic> map = {};

    ///[NOTES] put headers token here
    final String userToken = await CommonSharedPreferences.shared.load<String>(
      CommonSharedPreferences.headerTokenKey,
    );

    map["Content-Type"] = contentType;

    if (userToken.isNotEmpty) {
      map["Authorization"] = "Bearer $userToken";
    }

    return map;
  }

  Future<String> getUserIdFromToken() async {
    try {
      final String userToken = await CommonSharedPreferences.shared
          .load<String>(CommonSharedPreferences.headerTokenKey);

      final parts = userToken.split('.');
      if (parts.length != 3) {
        throw Exception('invalid token');
      }

      final payload = _decodeBase64(parts[1]);
      final payloadMap = await json.decode(payload);
      if (payloadMap is! Map<String, dynamic>) {
        throw Exception('invalid payload');
      }
      return payloadMap['iss'];
      // return userId;
    } catch (e) {
      rethrow;
    }
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
