import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
      if (apiKey.isNotEmpty) 'X-API-Key': apiKey,
      if (job.idempotencyKey.isNotEmpty) 'X-Idempotency-Key': job.idempotencyKey,
    };

    final meta = jsonEncode({
      'status': job.status.name,
      'retryCount': job.retryCount,
    });

    final uploadFile = await _prepareUploadFile(job.imagePath);
    final uploadFileName = uploadFile.path.split(Platform.pathSeparator).last;

    final formData = FormData.fromMap({
      'jobId': job.jobId,
      'clientTs': job.createdAt.toIso8601String(),
      'meta': meta,
      if (job.idempotencyKey.isNotEmpty) 'idempotencyKey': job.idempotencyKey,
      'image': await MultipartFile.fromFile(
        uploadFile.path,
        filename: uploadFileName,
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
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final targetWidth = image.width > 1600 ? 1600 : image.width;
      final targetHeight = (image.height * (targetWidth / image.width))
          .round()
          .clamp(1, 100000) as int;

      ui.Image scaledImage;
      if (targetWidth == image.width && targetHeight == image.height) {
        scaledImage = image;
      } else {
        final recorder = ui.PictureRecorder();
        final canvas = ui.Canvas(recorder);
        final paint = ui.Paint();
        canvas.scale(targetWidth / image.width, targetHeight / image.height);
        canvas.drawImage(image, ui.Offset.zero, paint);
        final picture = recorder.endRecording();
        scaledImage = await picture.toImage(targetWidth, targetHeight);
      }

      final byteData =
          await scaledImage.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return file;

      final encodedBytes = byteData.buffer.asUint8List();
      final tempDir = await Directory.systemTemp.createTemp('upload_');
      final compressedFile = File('${tempDir.path}/compressed.png');
      await compressedFile.writeAsBytes(encodedBytes);
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
      final webhookResponse = WebhookResponse(
        status: WebhookStatus.error,
        message: 'Unexpected response format',
      );
      return ErrorResult(
        response: webhookResponse,
        message: webhookResponse.message!,
      );
    }

    final webhookResponse = WebhookResponse.fromJson(data);

    switch (webhookResponse.status) {
      case WebhookStatus.ok:
        final belegId = webhookResponse.belegId;
        if (belegId == null || belegId.isEmpty) {
          return ErrorResult(
            response: webhookResponse,
            message: 'Missing belegId in response',
          );
        }

        return OkResult(
          response: webhookResponse,
          belegId: belegId,
          extracted: webhookResponse.extracted,
          message: webhookResponse.message,
        );
      case WebhookStatus.missingFields:
        final missing = webhookResponse.missing ?? [];
        return MissingFieldsResult(
          response: webhookResponse,
          missing: missing,
          extracted: webhookResponse.extracted,
          message: webhookResponse.message,
        );
      case WebhookStatus.error:
        return ErrorResult(
          response: webhookResponse,
          message:
              webhookResponse.message ?? 'Request failed with status $statusCode',
        );
    }
  }

  ErrorResult _errorResultFromResponse(Response<dynamic> response) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString() ??
          'Request failed with status ${response.statusCode}';
      final errorCode = data['errorCode']?.toString();
      final webhookResponse = WebhookResponse(
        status: WebhookStatus.error,
        message: message,
      );
      return ErrorResult(
        response: webhookResponse,
        message: message,
        errorCode: errorCode,
      );
    }

    final fallbackMessage = 'Request failed with status ${response.statusCode}';
    final webhookResponse = WebhookResponse(
      status: WebhookStatus.error,
      message: fallbackMessage,
    );

    return ErrorResult(
      response: webhookResponse,
      message: fallbackMessage,
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
