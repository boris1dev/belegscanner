import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/scan_job.dart';

class IsarProvider {
  IsarProvider._internal();

  static final IsarProvider _instance = IsarProvider._internal();

  factory IsarProvider() => _instance;

  Isar? _isar;

  Future<Isar> get instance async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ScanJobSchema],
      directory: dir.path,
    );

    return _isar!;
  }
}
