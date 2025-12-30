import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'package:belegscanner_mvp/models/scan_job.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('ScanJob is saved and loaded with server fields', () async {
    final tempDir = await Directory.systemTemp.createTemp('isar_test');

    final isar = await Isar.open(
      [ScanJobSchema],
      directory: tempDir.path,
    );

    final job = ScanJob()
      ..jobId = 'job-1'
      ..idempotencyKey = 'idem-1'
      ..status = ScanJobStatus.done
      ..createdAt = DateTime(2024, 1, 1)
      ..retryCount = 1
      ..imagePath = '/tmp/fake.jpg'
      ..serverBelegId = 'beleg-123'
      ..serverPayloadJson = '{"vendor":"Test"}'
      ..missingJson = '[{"field":"amount","label":"Betrag"}]'
      ..serverMessage = 'OK'
      ..serverStatus = 'ok';

    await isar.writeTxn(() => isar.scanJobs.put(job));

    final loaded = await isar.scanJobs.filter().jobIdEqualTo('job-1').findFirst();

    expect(loaded, isNotNull);
    expect(loaded!.serverBelegId, 'beleg-123');
    expect(loaded.serverPayloadJson, contains('vendor'));
    expect(loaded.missingJson, contains('amount'));
    expect(loaded.serverMessage, 'OK');
    expect(loaded.serverStatus, 'ok');

    await isar.close();
    await tempDir.delete(recursive: true);
  });
}
