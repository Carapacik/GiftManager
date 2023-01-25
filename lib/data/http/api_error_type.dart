enum ApiErrorType {
  incorrectPassword(21),
  notFound(103),
  missingParams('E_MISSING_OR_INVALID_PARAMS'),
  unknown('unknown');

  const ApiErrorType(this.code);

  final Object code;

  static ApiErrorType getByCode(Object code) {
    return ApiErrorType.values.firstWhere(
      (element) => element.code == code,
      orElse: () => ApiErrorType.unknown,
    );
  }
}
