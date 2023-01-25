import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response_dto.g.dart';

@JsonSerializable()
class RefreshTokenResponseDto extends Equatable {
  const RefreshTokenResponseDto({
    required this.token,
    required this.refreshToken,
  });

  factory RefreshTokenResponseDto.fromJson(final Map<String, dynamic> json) => _$RefreshTokenResponseDtoFromJson(json);

  final String token;
  final String refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenResponseDtoToJson(this);

  @override
  List<Object?> get props => [token, refreshToken];
}
