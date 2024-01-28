import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import '../../../utils/strings.dart';
import 'api_exception.dart';

class ApiService {
  static final _options = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: Duration(milliseconds:  AppConstants.connectionTimeout),
    receiveTimeout:  Duration(milliseconds: AppConstants.receiveTimeout),
    responseType: ResponseType.json,
  );

  // dio instance
  final Dio _dio = Dio(_options)
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true));

  // GET request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // String version = packageInfo.version;
      // String os_name = "android";
      // if (Platform.isIOS) {
      //   os_name = "ios";
      // } else {
      //   os_name = "android";
      // }
      // data["os"] = os_name;
      // data["version"] = version;
      // data["passwd"] = AppConstants.passwd;
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            // headers: setcustommheaders(data),
            contentType: Headers.formUrlEncodedContentType),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    }on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException.message;
    } /*catch (e) {
      rethrow;
    }*/
  }

  // PUT request
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // static setcustommheaders(Map<String, dynamic> data) {
  //   //String hs = AppConstants.api_key + data.values.join("") + AppConstants.salt;
  //   String hs = PrefUtil.api_key + data.values.join("") + AppConstants.salt;
  //
  //   var en = utf8.encode(hs);
  //   var value = sha512.convert(en);
  //   /*if (AppConstants.isdebug) {
  //     print("hash=>" + value.toString());
  //   }*/
  //   if (PrefUtil.isdebug) {
  //     print("hash=>" + value.toString());
  //   }
  //
  //  // if (AppConstants.isdebug) {
  //   if (PrefUtil.isdebug) {
  //     return {"api-key": value.toString(), "api-secret": "Stest"};
  //   } else {
  //     return {"api-key": value.toString(), "api-secret": 'Sz#\$x'};
  //   }
  // }
}
