import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/api_response.dart';
import '../models/scan_job.dart';
import '../services/api_client.dart';
import '../services/connectivity_service.dart';
import '../storage/job_repository.dart';

class UploadQueue {
  UploadQueue({
    required this.apiBaseUrl,
    required this.apiKey,
    ApiClient? apiClient,
    JobRepository? jobRepository,
    ConnectivityService? connectivityService,
  })  : _apiClient = apiClient ?? ApiClient(),
        _jobRepository = jobRepository ?? JobRepository(),
        _connectivityService =
            connectivityService ?? ConnectivityService();

  final String apiBaseUrl;
  final String apiKey;
  final ApiClient _apiClient;
  final JobRepository _jobRepository;
  final ConnectivityService _connectivityService;

  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  Future<void> processQueue() async {
    if (_isProcessing) {
      return;
    }

    _isProcessing = true;

    try {
      final jobs = await _jobRepository.getPendingOrFailed();
      if (jobs.isEmpty) {
        return;
      }

      final isOnline = await _connectivityService.isOnline();
      if (!isOnline) {
        const message = 'Kein Netz. Wird später gesendet.';
        debugPrint(message);
        for (final job in jobs) {
          job.lastError = message;
          await _jobRepository.upsert(job);
        }
        return;
      }

      for (final job in jobs) {
        job.status = ScanJobStatus.sending;
        job.lastAttemptAt = DateTime.now();
        await _jobRepository.upsert(job);

        try {
          final result = await _apiClient.uploadScanJob(
            job: job,
            apiBaseUrl: apiBaseUrl,
            apiKey: apiKey,
          );

          if (result is OkResult) {
            job.status = ScanJobStatus.done;
            job.serverBelegId = result.belegId;
            job.serverPayloadJson =
                result.extracted != null ? jsonEncode(result.extracted) : null;
            job.lastError = null;
            job.serverStatus = result.response.status.name;
            job.serverMessage = result.message;
            job.missingJson = null;
          } else if (result is MissingFieldsResult) {
            job.status = ScanJobStatus.needsFix;
            job.serverBelegId = result.response.belegId;
            job.serverPayloadJson =
                result.extracted != null ? jsonEncode(result.extracted) : null;
            job.missingJson = jsonEncode(result.missing
                .map(
                  (missing) => {
                    'field': missing.field,
                    'label': missing.label,
                  },
                )
                .toList());
            job.lastError = null;
            job.serverStatus = result.response.status.name;
            job.serverMessage = result.message;
          } else if (result is ErrorResult) {
            job.status = ScanJobStatus.failed;
            job.retryCount += 1;
            job.serverBelegId = null;
            job.serverPayloadJson = null;
            job.missingJson = null;
            job.lastError = result.message;
            job.serverStatus = result.response.status.name;
            job.serverMessage = result.message;
          }
        } on TransientNetworkException catch (e) {
          job.status = ScanJobStatus.failed;
          job.retryCount += 1;
          job.lastError = e.message;
          job.serverStatus = null;
          job.serverMessage = null;
          job.serverBelegId = null;
          job.serverPayloadJson = null;
          job.missingJson = null;
        } finally {
          await _jobRepository.upsert(job);
        }
      }
    } finally {
      _isProcessing = false;
    }
  }
}
