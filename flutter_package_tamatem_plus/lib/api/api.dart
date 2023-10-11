import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tamatem_plus/api/endpoints/tamatem_endpoint.dart';
import 'package:tamatem_plus/api/interceptors/interceptors.dart';
import 'package:tamatem_plus/api/interceptors/logger_interceptor.dart';
import 'package:tamatem_plus/utils/logger.dart';

class Api {
  static Api? instance;
  late Dio dio;
  late BaseOptions baseOptions;

  Api(String baseUrl) {
    baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      headers: {"version": "1.0"},
    );
    dio = Dio(baseOptions)
      ..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
  }

  static Api getInstance() {
    instance ??= Api(dotenv.env['TAMATEM_DOMAIN']!);
    return instance!;
  }

  get(url, {options, queryParameters, cancelToken}) async {
    Response response;
    try {
      try {
        logger.d('data => $url ${jsonEncode(queryParameters ?? '{}')}');
      } catch (e) {
        logger.e(e);
      }

      response = await dio.get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);
      return response.data;
    } on DioException catch (e) {
      logger.e('[get] DioException', error: e, stackTrace: e.stackTrace);
    } on Exception catch (e) {
      logger.e('[get] Exception', error: e);
    }
  }

  post(url, {options, data, cancelToken}) async {
    Response response;
    try {
      try {
        logger.d('data => $url ${jsonEncode(data ?? '{}')}');
      } catch (e) {
        logger.e(e);
      }

      response = await dio.post(url,
          options: options, data: data, cancelToken: cancelToken);
      return response.data;
    } on DioException catch (e) {
      logger.e('[post] DioException', error: e, stackTrace: e.stackTrace);
    } on Exception catch (e) {
      logger.e('[post] Exception', error: e);
    }
  }

  static void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  static TamatemPlusApi get core => TamatemPlusApi(getInstance());
}
