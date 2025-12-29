import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<bool> get online$ =>
      _connectivity.onConnectivityChanged.map(_anyConnected).distinct();

  Future<bool> isOnline() async {
    final connectivityResults = await _connectivity.checkConnectivity();
    return _anyConnected(connectivityResults);
  }

  bool _anyConnected(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}
