import 'dart:async';
import 'package:flutter/foundation.dart';

class SimulationPoint {
  final double lat;
  final double lng;
  SimulationPoint(this.lat, this.lng);
}

class DeliverySimulation {
  final String orderId;
  final String driverName;
  final String driverPhoto;
  final double driverRating;
  final String driverPhone;
  final String vehicleInfo;
  final SimulationPoint merchantPos;
  final SimulationPoint customerPos;
  final List<SimulationPoint> route;
  int currentIndex;
  final DateTime startTime;

  DeliverySimulation({
    required this.orderId,
    required this.driverName,
    required this.driverPhoto,
    required this.driverRating,
    required this.driverPhone,
    required this.vehicleInfo,
    required this.merchantPos,
    required this.customerPos,
    required this.route,
    this.currentIndex = 0,
    DateTime? startTime,
  }) : startTime = startTime ?? DateTime.now();

  SimulationPoint get currentPosition => route[currentIndex];
  double get progress => route.length > 1 ? currentIndex / (route.length - 1) : 1.0;
  bool get isComplete => currentIndex >= route.length - 1;
}

class SimulationService extends ChangeNotifier {
  final List<DeliverySimulation> _activeSimulations = [];
  Timer? _timer;
  int _orderCounter = 0;

  List<DeliverySimulation> get activeSimulations => _activeSimulations;

  static List<SimulationPoint> _generateRoute(
    SimulationPoint from, SimulationPoint to, int steps
  ) {
    final points = <SimulationPoint>[];
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      points.add(SimulationPoint(
        from.lat + (to.lat - from.lat) * t,
        from.lng + (to.lng - from.lng) * t,
      ));
    }
    return points;
  }

  static final _drivers = [
    {'name': 'Ahmed Hassan', 'photo': 'https://i.pravatar.cc/150?u=driver1', 'rating': 4.8, 'phone': '+201001234567', 'vehicle': 'Toyota Corolla · ABC 1234'},
    {'name': 'Mohamed Ali', 'photo': 'https://i.pravatar.cc/150?u=driver2', 'rating': 4.6, 'phone': '+201009876543', 'vehicle': 'Honda Civic · XYZ 5678'},
    {'name': 'Sara Ibrahim', 'photo': 'https://i.pravatar.cc/150?u=driver3', 'rating': 4.9, 'phone': '+201005566778', 'vehicle': 'Kia Rio · DEF 9012'},
  ];

  static final _merchantPositions = {
    'm1': SimulationPoint(30.0444, 31.2357),
    'm2': SimulationPoint(30.0520, 31.2400),
    'm3': SimulationPoint(30.0480, 31.2300),
    'm4': SimulationPoint(30.0460, 31.2450),
    'm5': SimulationPoint(30.0600, 31.2500),
    'm6': SimulationPoint(30.0550, 31.2380),
  };

  static final _customerPosition = SimulationPoint(30.0626, 31.2497);

  void createNewDelivery(String merchantId, String merchantName) {
    _orderCounter++;
    final orderId = 'NEX-${_orderCounter.toString().padLeft(4, '0')}';
    final driver = _drivers[_orderCounter % _drivers.length];
    final merchantPos = _merchantPositions[merchantId] ?? SimulationPoint(30.0444, 31.2357);

    final route = _generateRoute(merchantPos, _customerPosition, 20);

    _activeSimulations.add(DeliverySimulation(
      orderId: orderId,
      driverName: driver['name'] as String,
      driverPhoto: driver['photo'] as String,
      driverRating: (driver['rating'] as num).toDouble(),
      driverPhone: driver['phone'] as String,
      vehicleInfo: driver['vehicle'] as String,
      merchantPos: merchantPos,
      customerPos: _customerPosition,
      route: route,
    ));

    if (!_isRunning) _startTimer();
    notifyListeners();
  }

  bool get _isRunning => _timer != null && _timer!.isActive;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => _tick());
  }

  void _tick() {
    bool anyActive = false;
    for (final sim in _activeSimulations) {
      if (!sim.isComplete) {
        sim.currentIndex++;
        anyActive = true;
      }
    }
    if (!anyActive) {
      _timer?.cancel();
      _timer = null;
    }
    notifyListeners();
  }

  DeliverySimulation? getSimulation(String orderId) {
    try {
      return _activeSimulations.firstWhere((s) => s.orderId == orderId);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
