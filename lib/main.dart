import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/capture/capture_screen.dart';
import 'features/jobs/job_detail_screen.dart';
import 'models/scan_job.dart';
import 'app/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: BelegscannerApp()));
}

class BelegscannerApp extends StatelessWidget {
  const BelegscannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belegscanner MVP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const JobListScreen(),
        '/capture': (context) => const CaptureScreen(),
      },
      onGenerateRoute: (settings) {
        final name = settings.name ?? '';
        if (name == '/job' && settings.arguments is String) {
          return MaterialPageRoute(
            builder: (_) => JobDetailScreen(jobId: settings.arguments! as String),
            settings: settings,
          );
        }

        final uri = Uri.tryParse(name);
        if (uri != null && uri.pathSegments.length == 2 && uri.pathSegments.first == 'job') {
          final jobId = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (_) => JobDetailScreen(jobId: jobId),
            settings: settings,
          );
        }

        return MaterialPageRoute(
          builder: (_) => const UnknownRouteScreen(),
          settings: settings,
        );
      },
    );
  }
}

class JobListScreen extends ConsumerStatefulWidget {
  const JobListScreen({super.key});

  @override
  ConsumerState<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends ConsumerState<JobListScreen> {
  late Future<List<ScanJob>> _jobsFuture;
  bool _isSending = false;
  StreamSubscription<bool>? _connectivitySub;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _jobsFuture = _fetchJobs();
    _subscribeToConnectivity();
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _reload() async {
    setState(() {
      _jobsFuture = _fetchJobs();
    });
    await _jobsFuture;
  }

  Future<List<ScanJob>> _fetchJobs() {
    return ref.read(jobRepositoryProvider).getAllSorted();
  }

  Future<void> _processQueue() async {
    if (_isSending) return;

    setState(() {
      _isSending = true;
    });

    try {
      final uploadQueue = ref.read(uploadQueueProvider);
      await uploadQueue.processQueue();
      await _reload();
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  void _subscribeToConnectivity() {
    final connectivity = ref.read(connectivityProvider);
    _connectivitySub = connectivity.online$.listen((online) {
      if (!online) return;

      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          _processQueue();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final connectivity = ref.watch(connectivityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
      ),
      body: FutureBuilder<List<ScanJob>>(
        future: _jobsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final jobs = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: jobs.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          StreamBuilder<bool>(
                            stream: connectivity.online$,
                            initialData: null,
                            builder: (context, snapshot) {
                              final online = snapshot.data;
                              final color = online == true ? Colors.green : Colors.red;
                              final label = online == true ? 'Online' : 'Offline';

                              return Chip(
                                avatar: Icon(
                                  online == true
                                      ? Icons.cloud_done_rounded
                                      : Icons.cloud_off_rounded,
                                  color: Colors.white,
                                ),
                                label: Text(label),
                                backgroundColor: color,
                                labelStyle: const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                          const Spacer(),
                          FilledButton.icon(
                            onPressed: () => Navigator.pushNamed(context, '/capture'),
                            icon: const Icon(Icons.add_a_photo_outlined),
                            label: const Text('Neuer Beleg'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FilledButton.tonalIcon(
                        onPressed: _isSending ? null : _processQueue,
                        icon: _isSending
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.send_rounded),
                        label: Text(_isSending ? 'Sende...' : 'Jetzt senden'),
                      ),
                      const SizedBox(height: 12),
                      if (jobs.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text('Noch keine Scans vorhanden.'),
                          ),
                        ),
                    ],
                  );
                }

                final job = jobs[index - 1];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    title: Text('Job ${_shortJobId(job.jobId)}'),
                    subtitle: Text('Erstellt am ${_formatDate(job.createdAt)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _StatusChip(status: job.status),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(context, '/job/${job.jobId}'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
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

String _formatDate(DateTime dateTime) {
  final local = dateTime.toLocal();
  final date = local.toIso8601String().split('T').first;
  final time = local.toIso8601String().split('T')[1].split('.').first;
  return '$date, $time';
}

String _shortJobId(String jobId) {
  if (jobId.length <= 8) return jobId;
  return '${jobId.substring(0, 8)}…';
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ScanJobStatus status;

  Color get _color {
    switch (status) {
      case ScanJobStatus.pending:
        return Colors.orange.shade600;
      case ScanJobStatus.sending:
        return Colors.blue.shade600;
      case ScanJobStatus.needsFix:
        return Colors.purple.shade600;
      case ScanJobStatus.done:
        return Colors.green.shade600;
      case ScanJobStatus.failed:
        return Colors.red.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        _statusLabel(status),
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: _color,
    );
  }
}

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seite nicht gefunden'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            const Text('Die gewünschte Seite existiert nicht.'),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
              child: const Text('Zurück zur Übersicht'),
            ),
          ],
        ),
      ),
    );
  }
}
