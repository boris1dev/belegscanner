import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<bool> get online$ =>
      _connectivity.onConnectivityChanged.map(_isConnected).distinct();

  Future<bool> isOnline() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return _isConnected(connectivityResult);
  }

  bool _isConnected(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }
}
