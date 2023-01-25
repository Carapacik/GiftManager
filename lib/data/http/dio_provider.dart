import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:gift_manager/data/http/authorization_interceptor.dart';

class DioBuilder {
  DioBuilder() {
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger());
    }
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://giftmanager.skill-branch.ru/api',
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
    ),
  );

  Dio build() => _dio;

  DioBuilder addAuthorizationInterceptor(final AuthorizationInterceptor interceptor) {
    _dio.interceptors.add(interceptor);
    // ignore: avoid_returning_this
    return this;
  }
}
