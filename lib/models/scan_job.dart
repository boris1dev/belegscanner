import 'package:isar/isar.dart';

part 'scan_job.g.dart';

enum ScanJobStatus { pending, sending, needsFix, done, failed }

@collection
class ScanJob {
  Id id = Isar.autoIncrement;

  late String jobId;
  late DateTime createdAt;
  late String imagePath;
  late int retryCount;
  late String idempotencyKey;

  String? lastError;
  DateTime? lastAttemptAt;

  @enumerated
  late ScanJobStatus status;

  String? serverBelegId;
  String? serverPayloadJson;
}
