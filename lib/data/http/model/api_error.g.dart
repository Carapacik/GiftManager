// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
      code: json['code'] as Object,
      message: json['message'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'error': instance.error,
    };
