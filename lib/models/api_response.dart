enum WebhookStatus { ok, missingFields, error }

class WebhookResponse {
  WebhookResponse({
    required this.status,
    this.belegId,
    this.message,
    this.extracted,
    this.missing,
  });

  factory WebhookResponse.fromJson(Map<String, dynamic> json) {
    final statusValue = json['status']?.toString() ?? '';
    final status = _mapStatus(statusValue);

    return WebhookResponse(
      status: status,
      belegId: json['belegId']?.toString(),
      message: json['message']?.toString(),
      extracted: _parseExtracted(json['extracted']),
      missing: _parseMissing(json['missing']),
    );
  }

  static WebhookStatus _mapStatus(String status) {
    switch (status) {
      case 'ok':
        return WebhookStatus.ok;
      case 'missing_fields':
        return WebhookStatus.missingFields;
      case 'error':
      default:
        return WebhookStatus.error;
    }
  }

  static Map<String, dynamic>? _parseExtracted(dynamic extracted) {
    if (extracted is Map<String, dynamic>) {
      return extracted;
    }
    return null;
  }

  static List<MissingField>? _parseMissing(dynamic missing) {
    if (missing is! List) return null;

    return missing
        .whereType<Map<String, dynamic>>()
        .map(
          (field) => MissingField(
            field: field['field']?.toString() ?? '',
            label: field['label']?.toString() ?? '',
          ),
        )
        .toList();
  }

  final WebhookStatus status;
  final String? belegId;
  final String? message;
  final Map<String, dynamic>? extracted;
  final List<MissingField>? missing;
}

sealed class ApiResult {
  const ApiResult({required this.response});

  final WebhookResponse response;
}

class OkResult extends ApiResult {
  const OkResult({
    required super.response,
    required this.belegId,
    this.extracted,
    this.message,
  });

  final String belegId;
  final Map<String, dynamic>? extracted;
  final String? message;
}

class MissingFieldsResult extends ApiResult {
  const MissingFieldsResult({
    required super.response,
    required this.missing,
    this.extracted,
    this.message,
  });

  final List<MissingField> missing;
  final Map<String, dynamic>? extracted;
  final String? message;
}

class ErrorResult extends ApiResult {
  const ErrorResult({
    required super.response,
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
