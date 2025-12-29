import 'package:isar/isar.dart';

import '../models/scan_job.dart';
import 'isar_provider.dart';

class JobRepository {
  JobRepository({IsarProvider? isarProvider})
      : _isarProvider = isarProvider ?? IsarProvider();

  final IsarProvider _isarProvider;

  Future<void> upsert(ScanJob job) async {
    final isar = await _isarProvider.instance;
    await isar.writeTxn(() async {
      await isar.scanJobs.put(job);
    });
  }

  Future<List<ScanJob>> getAllSorted() async {
    final isar = await _isarProvider.instance;
    final jobs = await isar.scanJobs.where().findAll();
    jobs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return jobs;
  }

  Future<List<ScanJob>> getPendingOrFailed() async {
    final isar = await _isarProvider.instance;
    return isar.scanJobs
        .filter()
        .statusEqualTo(ScanJobStatus.pending)
        .or()
        .statusEqualTo(ScanJobStatus.failed)
        .findAll();
  }

  Future<ScanJob?> getByJobId(String jobId) async {
    final isar = await _isarProvider.instance;
    return isar.scanJobs.where().jobIdEqualTo(jobId).findFirst();
  }

  Future<void> deleteByJobId(String jobId) async {
    final isar = await _isarProvider.instance;
    await isar.writeTxn(() async {
      await isar.scanJobs.filter().jobIdEqualTo(jobId).deleteAll();
    });
  }
}
