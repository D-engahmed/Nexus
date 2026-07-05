import 'package:flutter/foundation.dart';
import '../../../core/services/simulation_service.dart';

class TrackingData {
  final String orderId;
  final String status;
  final String driverName;
  final String driverPhoto;
  final double driverRating;
  final String driverPhone;
  final String vehicleInfo;
  final double merchantLat;
  final double merchantLng;
  final double customerLat;
  final double customerLng;
  final double driverLat;
  final double driverLng;
  final double progress;
  final List<Map<String, dynamic>> timeline;

  TrackingData({
    required this.orderId,
    required this.status,
    required this.driverName,
    required this.driverPhoto,
    required this.driverRating,
    required this.driverPhone,
    required this.vehicleInfo,
    required this.merchantLat,
    required this.merchantLng,
    required this.customerLat,
    required this.customerLng,
    required this.driverLat,
    required this.driverLng,
    required this.progress,
    required this.timeline,
  });
}

class TrackingProvider extends ChangeNotifier {
  TrackingData? _trackingData;
  String? _activeOrderId;

  TrackingData? get trackingData => _trackingData;
  String? get activeOrderId => _activeOrderId;

  void startTracking(String orderId, DeliverySimulation sim) {
    _activeOrderId = orderId;
    _updateFromSimulation(sim);
  }

  void updateFromSimulation(DeliverySimulation sim) {
    if (sim.orderId != _activeOrderId) return;
    _updateFromSimulation(sim);
  }

  void _updateFromSimulation(DeliverySimulation sim) {
    String status;
    if (sim.progress < 0.05) {
      status = 'Driver Assigned';
    } else if (sim.progress < 0.45) {
      status = 'Picked Up';
    } else if (sim.progress < 0.95) {
      status = 'In Transit';
    } else {
      status = 'Arriving Soon';
    }

    final timeline = <Map<String, dynamic>>[
      {'status': 'Order Placed', 'timestamp': sim.startTime.toIso8601String(), 'icon': 'receipt'},
      {'status': 'Driver Assigned', 'timestamp': sim.startTime.add(const Duration(minutes: 1)).toIso8601String(), 'icon': 'person'},
      {'status': 'Picked Up', 'timestamp': sim.startTime.add(const Duration(minutes: 5)).toIso8601String(), 'icon': 'inventory'},
      {'status': 'In Transit', 'timestamp': DateTime.now().toIso8601String(), 'icon': 'local_shipping'},
    ];

    _trackingData = TrackingData(
      orderId: sim.orderId,
      status: status,
      driverName: sim.driverName,
      driverPhoto: sim.driverPhoto,
      driverRating: sim.driverRating,
      driverPhone: sim.driverPhone,
      vehicleInfo: sim.vehicleInfo,
      merchantLat: sim.merchantPos.lat,
      merchantLng: sim.merchantPos.lng,
      customerLat: sim.customerPos.lat,
      customerLng: sim.customerPos.lng,
      driverLat: sim.currentPosition.lat,
      driverLng: sim.currentPosition.lng,
      progress: sim.progress,
      timeline: timeline,
    );
    notifyListeners();
  }

  void stopTracking() {
    _activeOrderId = null;
    _trackingData = null;
    notifyListeners();
  }
}
