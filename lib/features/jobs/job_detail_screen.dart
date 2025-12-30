import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../models/scan_job.dart';

class JobDetailScreen extends ConsumerStatefulWidget {
  const JobDetailScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen> {
  ScanJob? _job;
  bool _isLoading = true;
  bool _isProcessing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadJob();
  }

  Future<void> _loadJob() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repository = ref.read(jobRepositoryProvider);
      final job = await repository.getByJobId(widget.jobId);
      setState(() {
        _job = job;
      });
    } catch (e) {
      setState(() {
        _error = 'Job konnte nicht geladen werden.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resendJob() async {
    final job = _job;
    if (job == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      job.status = ScanJobStatus.pending;
      job.lastError = null;
      job.lastAttemptAt = null;
      await ref.read(jobRepositoryProvider).upsert(job);

      final queue = ref.read(uploadQueueProvider);
      await queue.processQueue();
      await _loadJob();
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _deleteJobAndFile() async {
    final job = _job;
    if (job == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      await ref.read(jobRepositoryProvider).deleteByJobId(job.jobId);
      await File(job.imagePath).delete().catchError((_) {});

      if (!mounted) return;
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _rescan() async {
    final job = _job;
    if (job == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      await ref.read(jobRepositoryProvider).deleteByJobId(job.jobId);
      await File(job.imagePath).delete().catchError((_) {});

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/capture');
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  List<Map<String, String>> _parseMissingFields(String? jsonPayload) {
    if (jsonPayload == null) return [];
    try {
      final decoded = jsonDecode(jsonPayload);
      final missing = decoded['missing'];
      if (missing is List) {
        return missing
            .whereType<Map<String, dynamic>>()
            .map(
              (item) => {
                'field': item['field']?.toString() ?? '',
                'label': item['label']?.toString() ?? '',
              },
            )
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Job-Details')),
        body: Center(child: Text(_error!)),
      );
    }

    final job = _job;
    if (job == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Job-Details')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search_off, size: 48),
              const SizedBox(height: 12),
              const Text('Job konnte nicht gefunden werden.'),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () =>
                    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
                child: const Text('Zurück zur Liste'),
              ),
            ],
          ),
        ),
      );
    }

    final missingFields = _parseMissingFields(job.serverPayloadJson);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job-Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Job-ID',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        job.jobId,
                        style:
                            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Chip(label: Text('${_statusLabel(job.status)} • ${job.retryCount}x')),
              ],
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: _buildImagePreview(job.imagePath),
              ),
            ),
            const SizedBox(height: 24),
            if (job.status == ScanJobStatus.needsFix && missingFields.isNotEmpty) ...[
              const Text(
                'Fehlende Felder',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              ...missingFields.map(
                (item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  title: Text(item['label'] ?? item['field'] ?? ''),
                  subtitle: item['field'] != null && item['field']!.isNotEmpty
                      ? Text(item['field']!)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (job.status == ScanJobStatus.done && job.serverBelegId != null) ...[
              const Text(
                'Beleg-ID',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              SelectableText(job.serverBelegId!),
              const SizedBox(height: 16),
            ],
            if (job.lastError != null) ...[
              const Text(
                'Letzte Fehlermeldung',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(job.lastError!),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _isProcessing ? null : _resendJob,
                    icon: _isProcessing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send_rounded),
                    label: const Text('Erneut senden'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isProcessing ? null : _rescan,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Neu scannen'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: _isProcessing ? null : _deleteJobAndFile,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'Löschen',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      return Container(
        color: Colors.grey.shade200,
        child: const Center(child: Text('Bild nicht gefunden')),
      );
    }

    return Image.file(file, fit: BoxFit.cover);
  }
}

String _statusLabel(ScanJobStatus status) {
  switch (status) {
    case ScanJobStatus.pending:
      return 'Ausstehend';
    case ScanJobStatus.sending:
      return 'Sende...';
    case ScanJobStatus.needsFix:
      return 'Erfordert Prüfung';
    case ScanJobStatus.done:
      return 'Fertig';
    case ScanJobStatus.failed:
      return 'Fehlgeschlagen';
  }
}
