import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:gift_manager/data/http/api_error_type.dart';
import 'package:gift_manager/data/http/model/api_error.dart';

class BaseApiService {
  Future<Either<ApiError, T>> responseOrError<T>(
    AsyncValueGetter<T> request,
  ) async {
    try {
      return Right(await request());
    } on Object catch (e) {
      return Left(_getApiError(e));
    }
  }

  ApiError _getApiError(final Object e) {
    if (e is DioError) {
      if (e.type == DioErrorType.response && e.response != null) {
        try {
          final apiError = ApiError.fromJson(e.response!.data as Map<String, dynamic>);
          return apiError;
        } on Object catch (_) {
          return const ApiError(code: ApiErrorType.unknown);
        }
      }
    }
    return const ApiError(code: ApiErrorType.unknown);
  }
}
