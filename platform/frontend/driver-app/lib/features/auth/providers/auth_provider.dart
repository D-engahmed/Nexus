import 'package:flutter/foundation.dart';
import '../../../core/services/mock_data.dart';

class AuthProvider extends ChangeNotifier {
  Map<String, dynamic>? _user;
  bool _isLoading = false;
  String? _error;
  bool _online = true;

  Map<String, dynamic>? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  bool get online => _online;

  bool login(String email, String password) {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final found = MockData.drivers.cast<Map<String, dynamic>>().firstWhere(
      (d) => d['email'] == email && d['password'] == password,
      orElse: () => <String, dynamic>{},
    );

    if (found.isEmpty) {
      _error = 'Invalid email or password';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _user = found;
    _online = found['online'] as bool;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  void toggleOnline() {
    _online = !_online;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
