import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/scan_job.dart';
import '../../storage/job_repository.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  CameraController? _controller;
  late Future<void> _initializeFuture;
  bool _isSaving = false;
  String? _errorMessage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeFuture = _setupCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _setupCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _errorMessage = 'Keine Kamera gefunden.';
        });
        return;
      }

      final controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      _controller = controller;
      await controller.initialize();
    } catch (e) {
      setState(() {
        _errorMessage = 'Kamera konnte nicht initialisiert werden.';
      });
    }
  }

  Future<void> _captureAndSave() async {
    if (_isSaving) return;
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final picture = await controller.takePicture();
      await _handleCapturedImage(File(picture.path), deleteAfterSave: true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aufnahme fehlgeschlagen. Bitte erneut versuchen.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _pickFromGallery() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final result = await _picker.pickImage(source: ImageSource.gallery);
      if (result == null) return;
      final tempCopy = await _copyToTempFile(result.path);
      await _handleCapturedImage(tempCopy, deleteAfterSave: true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konnte kein Foto auswählen.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<File> _copyToTempFile(String sourcePath) async {
    final tempDir = await Directory.systemTemp.createTemp('gallery_copy');
    final target = File('${tempDir.path}/${const Uuid().v4()}.jpg');
    return File(sourcePath).copy(target.path);
  }

  Future<void> _handleCapturedImage(File file, {required bool deleteAfterSave}) async {
    final keep = await _showPreviewDialog(file.path);
    if (keep != true) {
      await file.delete().catchError((_) {});
      return;
    }

    final jobId = const Uuid().v4();
    final idempotencyKey = const Uuid().v4();

    final documentsDir = await getApplicationDocumentsDirectory();
    final scansDir = Directory('${documentsDir.path}/scans');
    await scansDir.create(recursive: true);
    final targetPath = '${scansDir.path}/$jobId.jpg';

    File savedFile;
    if (deleteAfterSave) {
      savedFile = await file.rename(targetPath);
    } else {
      savedFile = await file.copy(targetPath);
    }

    final job = ScanJob()
      ..jobId = jobId
      ..idempotencyKey = idempotencyKey
      ..status = ScanJobStatus.pending
      ..createdAt = DateTime.now()
      ..retryCount = 0
      ..imagePath = savedFile.path;

    await JobRepository().upsert(job);

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/job/$jobId',
      ModalRoute.withName('/'),
    );
  }

  Future<bool?> _showPreviewDialog(String path) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(12),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Vorschau', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(File(path), fit: BoxFit.cover),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await File(path).delete().catchError((_) {});
                if (context.mounted) Navigator.of(context).pop(false);
              },
              child: const Text('Verwerfen'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Behalten'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beleg erfassen'),
      ),
      body: FutureBuilder<void>(
        future: _initializeFuture,
        builder: (context, snapshot) {
          if (_errorMessage != null) {
            return _ErrorState(
              message: _errorMessage!,
              onPickFromGallery: _pickFromGallery,
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller == null || !_controller!.value.isInitialized) {
            return _ErrorState(
              message: 'Kamera steht nicht bereit.',
              onPickFromGallery: _pickFromGallery,
            );
          }

          return Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _isSaving ? null : _captureAndSave,
                    icon: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.camera_alt_outlined),
                    label: Text(_isSaving ? 'Speichern...' : 'Foto aufnehmen'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, this.onPickFromGallery});

  final String message;
  final VoidCallback? onPickFromGallery;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 12),
          Text(message),
          const SizedBox(height: 24),
          if (onPickFromGallery != null) ...[
            FilledButton.icon(
              onPressed: onPickFromGallery,
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Aus Fotos wählen'),
            ),
            const SizedBox(height: 12),
          ],
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zurück'),
          ),
        ],
      ),
    );
  }
}
