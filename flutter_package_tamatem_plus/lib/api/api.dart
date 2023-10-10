import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/logger.dart';
import 'endpoints/tamatem_endpoint.dart';
import 'interceptors/logger_interceptor.dart';

class Api {
  static Api? instance;
  late Dio dio;
  late Dio dioGo;
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
        LoggerInterceptor(),
      ]);
  }

  static Api getInstance() {
    instance ??= Api(dotenv.env['TAMATEM_DOMAIN']!);
    return instance!;
  }

  get(url,
      {options, queryParameters, data, cancelToken, onSendProgress}) async {
    Response response;
    try {
      try {
        logger.d('data => $url ${jsonEncode(data ?? '{}')}');
      } catch (e) {
        logger.e(e);
      }

      response = await dio.get(url,
          queryParameters: queryParameters,
          options: options,
          data: data,
          cancelToken: cancelToken);
      logger.d('response---: $response');
      return response.data;
    } on DioException catch (e) {
      logger.e('[post] DioException', error: e, stackTrace: e.stackTrace);
    } on Exception catch (e) {
      logger.e('[post] Exception', error: e);
    }
  }

  // post(url, {options, data, cancelToken, onSendProgress, baseUrl}) async {
  //   Response response;
  //   try {
  //     try {
  //       logger.d('data => $url ${jsonEncode(data ?? '{}')}');
  //     } catch (e) {
  //       logger.e(e);
  //     }

  //     if (baseUrl != null) {
  //       dio.options.baseUrl = baseUrl;
  //     } else {
  //       dio.options.baseUrl = Endpoints.kPlant;
  //     }

  //     response = await dio.post(url,
  //         options: options,
  //         data: data,
  //         cancelToken: cancelToken,
  //         onSendProgress: onSendProgress);
  //     return response.data;
  //   } on DioException catch (e) {
  //     logger.e('[post] DioException', error: e);
  //   } on Exception catch (e) {
  //     logger.e('[post] Exception', error: e);
  //   }
  // }

  // put(url, {options, data, cancelToken, onSendProgress}) async {
  //   Response response;
  //   try {
  //     dio.options.baseUrl = '';
  //     dio.options.headers["Content-Type"] = "multipart/form-data";
  //     response = await dio.put(url,
  //         options: options,
  //         data: data,
  //         cancelToken: cancelToken,
  //         onSendProgress: onSendProgress);

  //     logger.d(
  //         'response------headers-${response.requestOptions}--: ${response.headers}');
  //     logger.d('response------code---: ${response.statusCode}');
  //     logger.d('response------data---: ${response.data}');
  //     return response;
  //   } on DioException catch (e) {
  //     logger.e('[put] DioException', error: e);
  //   } on Exception catch (e) {
  //     logger.e('[put] Exception', error: e);
  //   }
  // }

  static void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  static TamatemPlusApi get core => TamatemPlusApi(getInstance());
}
