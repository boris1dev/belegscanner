import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<bool> get online$ async* {
    yield await isOnline();
    yield* _connectivity.onConnectivityChanged.map(_anyConnected).distinct();
  }

  Future<bool> isOnline() async {
    final connectivityResults = await _connectivity.checkConnectivity();
    return _anyConnected(connectivityResults);
  }

  bool _anyConnected(dynamic results) {
    if (results is List<ConnectivityResult>) {
      return results.any((result) => result != ConnectivityResult.none);
    }

    if (results is ConnectivityResult) {
      return results != ConnectivityResult.none;
    }

    return false;
  }
}
