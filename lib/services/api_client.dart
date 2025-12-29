import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart'
    as img show Image, copyResize, decodeImage, encodeJpg;
import '../models/api_response.dart';
import '../models/scan_job.dart';

class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options = _dio.options.copyWith(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 60),
    );
  }

  final Dio _dio;

  Future<ApiResult> uploadScanJob({
    required ScanJob job,
    required String apiBaseUrl,
    required String apiKey,
  }) async {
    final headers = {
      'X-API-Key': apiKey,
      if (job.idempotencyKey.isNotEmpty) 'X-Idempotency-Key': job.idempotencyKey,
    };

    final meta = jsonEncode({
      'status': job.status.name,
      'retryCount': job.retryCount,
    });

    final uploadFile = await _prepareUploadFile(job.imagePath);

    final formData = FormData.fromMap({
      'jobId': job.jobId,
      'clientTs': job.createdAt.toIso8601String(),
      'meta': meta,
      if (job.idempotencyKey.isNotEmpty) 'idempotencyKey': job.idempotencyKey,
      'image': await MultipartFile.fromFile(
        uploadFile.path,
        filename: 'image.jpg',
      ),
    });

    try {
      final response = await _dio.post(
        apiBaseUrl,
        data: formData,
        options: Options(headers: headers),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      if (_isNetworkError(e)) {
        throw TransientNetworkException(
          _mapNetworkMessage(e.type),
        );
      }

      final response = e.response;
      if (response != null) {
        return _errorResultFromResponse(response);
      }

      throw TransientNetworkException(
        _mapNetworkMessage(e.type),
      );
    } on SocketException catch (_) {
      throw TransientNetworkException('Kein Netz. Wird später gesendet.');
    }
  }

  Future<File> _prepareUploadFile(String path) async {
    final file = File(path);

    try {
      final bytes = await file.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return file;

      final resized = decoded.width > 1600
          ? img.copyResize(decoded, width: 1600)
          : decoded;

      final jpgBytes = img.encodeJpg(resized, quality: 80);
      final tempDir = await Directory.systemTemp.createTemp('upload_');
      final compressedFile = File('${tempDir.path}/compressed.jpg');
      await compressedFile.writeAsBytes(jpgBytes);
      return compressedFile;
    } catch (e) {
      debugPrint('Image compression skipped: $e');
      return file;
    }
  }

  ApiResult _handleResponse(Response<dynamic> response) {
    final statusCode = response.statusCode ?? 500;
    final data = response.data;

    if (statusCode >= 400) {
      return _errorResultFromResponse(response);
    }

    if (data is! Map<String, dynamic>) {
      return ErrorResult(message: 'Unexpected response format');
    }

    final missing = data['missingFields'] ?? data['missing'];
    final extracted = data['extracted'];
    final message = data['message']?.toString() ?? 'Success';

    if (missing is List) {
      final missingFields = missing
          .whereType<Map<String, dynamic>>()
          .map(
            (field) => MissingField(
              field: field['field']?.toString() ?? '',
              label: field['label']?.toString() ?? '',
            ),
          )
          .toList();

      return MissingFieldsResult(
        missing: missingFields,
        extracted: extracted is Map<String, dynamic> ? extracted : null,
        message: message,
      );
    }

    final belegId = data['belegId']?.toString();
    if (belegId == null || belegId.isEmpty) {
      return ErrorResult(message: 'Missing belegId in response');
    }

    return OkResult(
      belegId: belegId,
      extracted: extracted is Map<String, dynamic> ? extracted : null,
      message: message,
    );
  }

  ErrorResult _errorResultFromResponse(Response<dynamic> response) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString() ??
          'Request failed with status ${response.statusCode}';
      final errorCode = data['errorCode']?.toString();
      return ErrorResult(message: message, errorCode: errorCode);
    }

    return ErrorResult(
      message: 'Request failed with status ${response.statusCode}',
    );
  }

  bool _isNetworkError(DioException exception) {
    return exception.type == DioExceptionType.connectionTimeout ||
        exception.type == DioExceptionType.receiveTimeout ||
        exception.type == DioExceptionType.sendTimeout ||
        exception.type == DioExceptionType.connectionError;
  }

  String _mapNetworkMessage(DioExceptionType type) {
    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return 'Server antwortet nicht. Wir versuchen es erneut.';
    }

    return 'Kein Netz. Wird später gesendet.';
  }
}

class TransientNetworkException implements Exception {
  TransientNetworkException(this.message);

  final String message;

  @override
  String toString() => 'TransientNetworkException: $message';
}
