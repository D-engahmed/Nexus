import 'dart:async';
import 'package:flutter/foundation.dart';

class NavigationStep {
  final String instruction;
  final double distance;
  final String icon;

  NavigationStep({required this.instruction, required this.distance, required this.icon});
}

class NavigationProvider extends ChangeNotifier {
  bool _isNavigating = false;
  double _progress = 0;
  Timer? _timer;
  String _currentPhase = 'to_merchant';
  List<NavigationStep> _steps = [];

  bool get isNavigating => _isNavigating;
  double get progress => _progress;
  String get currentPhase => _currentPhase;
  List<NavigationStep> get steps => _steps;

  void startNavigation(double merchantLat, double merchantLng, double customerLat, double customerLng) {
    _isNavigating = true;
    _progress = 0;
    _currentPhase = 'to_merchant';

    _steps = [
      NavigationStep(instruction: 'Head to merchant location', distance: 0.5, icon: '📍'),
      NavigationStep(instruction: 'Park at designated spot', distance: 0.1, icon: '🅿️'),
      NavigationStep(instruction: 'Pick up the order', distance: 0, icon: '📦'),
    ];

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => _tick());
    notifyListeners();
  }

  void _tick() {
    if (_progress >= 1.0) {
      if (_currentPhase == 'to_merchant') {
        _currentPhase = 'to_customer';
        _progress = 0;
        _steps = [
          NavigationStep(instruction: 'Leave merchant', distance: 0.3, icon: '🚚'),
          NavigationStep(instruction: 'Drive to customer address', distance: 2.0, icon: '📍'),
          NavigationStep(instruction: 'Arrive at destination', distance: 0.5, icon: '🏁'),
        ];
      } else {
        _isNavigating = false;
        _timer?.cancel();
        _timer = null;
        notifyListeners();
        return;
      }
    }
    _progress = (_progress + 0.05).clamp(0, 1);
    notifyListeners();
  }

  String get currentInstruction {
    if (!_isNavigating) return '';
    final phase = _currentPhase == 'to_merchant' ? 'Head to merchant' : 'Deliver to customer';
    final dist = ((1 - _progress) * 3).toStringAsFixed(1);
    return '$phase — $dist km remaining';
  }

  void stopNavigation() {
    _timer?.cancel();
    _timer = null;
    _isNavigating = false;
    _progress = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
