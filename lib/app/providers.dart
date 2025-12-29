import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/connectivity_service.dart';
import '../services/upload_queue.dart';
import '../storage/isar_provider.dart';
import '../storage/job_repository.dart';
import 'config.dart';

final isarProvider = Provider<IsarProvider>((ref) => IsarProvider());

final jobRepositoryProvider = Provider<JobRepository>(
  (ref) => JobRepository(
    isarProvider: ref.watch(isarProvider),
  ),
);

final connectivityProvider =
    Provider<ConnectivityService>((ref) => ConnectivityService());

final apiConfigProvider = Provider<ApiConfig>((ref) => defaultApiConfig);

final uploadQueueProvider = Provider<UploadQueue>(
  (ref) {
    final apiConfig = ref.watch(apiConfigProvider);
    return UploadQueue(
      apiBaseUrl: apiConfig.apiBaseUrl,
      apiKey: apiConfig.apiKey,
      jobRepository: ref.watch(jobRepositoryProvider),
      connectivityService: ref.watch(connectivityProvider),
    );
  },
);
