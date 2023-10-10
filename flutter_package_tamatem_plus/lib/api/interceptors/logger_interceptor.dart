import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tamatem_plus/utils/logger.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final requestPath = '${options.baseUrl}${options.path}';
      logger.i('${options.method} request => $requestPath');
      logger.d('headers => ${options.headers}');
      logger.d('queryParameters => ${options.queryParameters}');
      logger
          .d('data => ${options.data != null ? jsonEncode(options.data) : {}}');
    } catch (e) {
      // ignore
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final options = response.requestOptions;
      final requestPath = '${options.baseUrl}${options.path}';
      logger.i('response <= $requestPath StatusCode: ${response.statusCode}');
      logger.d(
          'data <= ${response.data != null ? jsonEncode(response.data) : {}}');
    } catch (e) {
      // ignore
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final options = err.requestOptions;
      final requestPath = '${options.baseUrl}${options.path}';
      logger.e('${options.method} request => $requestPath');
      logger.d('Error: ${err.error}, Message: ${err.message}');
    } catch (e) {
      // ignore
    }
    super.onError(err, handler);
  }
}
