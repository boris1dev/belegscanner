sealed class ApiResult {
  const ApiResult();
}

class OkResult extends ApiResult {
  const OkResult({
    required this.belegId,
    this.extracted,
    required this.message,
  });

  final String belegId;
  final Map<String, dynamic>? extracted;
  final String message;
}

class MissingFieldsResult extends ApiResult {
  const MissingFieldsResult({
    required this.missing,
    this.extracted,
    required this.message,
  });

  final List<MissingField> missing;
  final Map<String, dynamic>? extracted;
  final String message;
}

class ErrorResult extends ApiResult {
  const ErrorResult({
    required this.message,
    this.errorCode,
  });

  final String message;
  final String? errorCode;
}

class MissingField {
  const MissingField({
    required this.field,
    required this.label,
  });

  final String field;
  final String label;
}
