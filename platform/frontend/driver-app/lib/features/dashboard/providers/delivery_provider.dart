import 'package:flutter/foundation.dart';
import '../../../core/services/mock_data.dart';

class AssignedDelivery {
  final String id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerPhoto;
  final String merchantName;
  final String merchantAddress;
  final String merchantId;
  final double merchantLat;
  final double merchantLng;
  final double customerLat;
  final double customerLng;
  final List<Map<String, dynamic>> items;
  final double total;
  final String status;
  final String distance;
  final String pickupTime;

  AssignedDelivery({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerPhoto,
    required this.merchantName,
    required this.merchantAddress,
    required this.merchantId,
    required this.merchantLat,
    required this.merchantLng,
    required this.customerLat,
    required this.customerLng,
    required this.items,
    required this.total,
    required this.status,
    required this.distance,
    required this.pickupTime,
  });
}

class DeliveryProvider extends ChangeNotifier {
  List<AssignedDelivery> _deliveries = [];
  List<Map<String, dynamic>> _completedDeliveries = [];

  List<AssignedDelivery> get deliveries => _deliveries;
  List<Map<String, dynamic>> get completedDeliveries => _completedDeliveries;
  AssignedDelivery? get activeDelivery => _deliveries.isNotEmpty ? _deliveries.first : null;

  DeliveryProvider() {
    _deliveries = MockData.assignedOrders
        .map((d) => AssignedDelivery(
              id: d['id'] as String,
              customerName: d['customerName'] as String,
              customerPhone: d['customerPhone'] as String,
              customerAddress: d['customerAddress'] as String,
              customerPhoto: d['customerPhoto'] as String,
              merchantName: d['merchantName'] as String,
              merchantAddress: d['merchantAddress'] as String,
              merchantId: d['merchantId'] as String,
              merchantLat: (d['merchantLat'] as num).toDouble(),
              merchantLng: (d['merchantLng'] as num).toDouble(),
              customerLat: (d['customerLat'] as num).toDouble(),
              customerLng: (d['customerLng'] as num).toDouble(),
              items: (d['items'] as List).cast<Map<String, dynamic>>(),
              total: (d['total'] as num).toDouble(),
              status: d['status'] as String,
              distance: d['distance'] as String,
              pickupTime: d['pickupTime'] as String,
            ))
        .toList();
    _completedDeliveries = List.from(MockData.completedDeliveries);
  }

  void updateStatus(String deliveryId, String newStatus) {
    final idx = _deliveries.indexWhere((d) => d.id == deliveryId);
    if (idx >= 0) {
      final d = _deliveries[idx];
      _deliveries[idx] = AssignedDelivery(
        id: d.id, customerName: d.customerName, customerPhone: d.customerPhone,
        customerAddress: d.customerAddress, customerPhoto: d.customerPhoto,
        merchantName: d.merchantName, merchantAddress: d.merchantAddress,
        merchantId: d.merchantId, merchantLat: d.merchantLat, merchantLng: d.merchantLng,
        customerLat: d.customerLat, customerLng: d.customerLng,
        items: d.items, total: d.total, status: newStatus,
        distance: d.distance, pickupTime: d.pickupTime,
      );
      notifyListeners();
    }
  }

  void acceptDelivery(String deliveryId) {
    updateStatus(deliveryId, 'PENDING_PICKUP');
  }

  void pickupComplete(String deliveryId) {
    updateStatus(deliveryId, 'IN_TRANSIT');
  }

  void markDelivered(String deliveryId) {
    _deliveries.removeWhere((d) => d.id == deliveryId);
    notifyListeners();
  }
}
