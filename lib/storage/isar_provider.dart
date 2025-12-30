import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/scan_job.dart';

class IsarProvider {
  IsarProvider._internal();

  static final IsarProvider _instance = IsarProvider._internal();

  factory IsarProvider() => _instance;

  Isar? _isar;
  Completer<Isar>? _opening;

  Future<Isar> get instance async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }

    if (_opening != null) {
      return _opening!.future;
    }

    _opening = Completer<Isar>();

    try {
      _isar = await _initIsar();
      _opening!.complete(_isar!);
      return _isar!;
    } catch (e, stackTrace) {
      _opening!.completeError(e, stackTrace);
      rethrow;
    } finally {
      _opening = null;
    }
  }

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    await Directory(dir.path).create(recursive: true);

    try {
      return await Isar.open(
        [ScanJobSchema],
        directory: dir.path,
      );
    } on IsarError {
      await _clearDirectory(dir.path);

      return Isar.open(
        [ScanJobSchema],
        directory: dir.path,
      );
    }
  }

  Future<void> _clearDirectory(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) return;

    await for (final entity in dir.list(recursive: true)) {
      try {
        await entity.delete(recursive: true);
      } on FileSystemException {
        // Best-effort cleanup; continue deleting the remaining files.
      }
    }
    await dir.create(recursive: true);
  }
}
