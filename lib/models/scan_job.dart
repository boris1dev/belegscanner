import 'package:isar/isar.dart';

part 'scan_job.g.dart';

enum ScanJobStatus {
  pending,
  sending,
  needsFix,
  done,
  failed,
}

@collection
class ScanJob {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String jobId;

  late DateTime createdAt;

  @enumerated
  late ScanJobStatus status;

  late String imagePath;

  late int retryCount;

  String? lastError;

  @Index(unique: true)
  late String idempotencyKey;

  DateTime? lastAttemptAt;


  String? serverBelegId;
  String? serverPayloadJson;
}
