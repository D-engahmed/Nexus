import 'package:flutter/foundation.dart';

class OrderItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  OrderItem({required this.id, required this.name, required this.price, this.quantity = 1});

  double get total => price * quantity;
}

class AppOrder {
  final String id;
  final String merchantId;
  final String merchantName;
  final String merchantImage;
  final List<OrderItem> items;
  final double total;
  final String status;
  final String createdAt;
  final String deliveryAddress;

  AppOrder({
    required this.id,
    required this.merchantId,
    required this.merchantName,
    required this.merchantImage,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    this.deliveryAddress = '42 Nile St, Garden City',
  });
}

class OrderProvider extends ChangeNotifier {
  final List<AppOrder> _orders = [];
  final List<Map<String, dynamic>> _cart = [];

  List<AppOrder> get orders => _orders;
  List<Map<String, dynamic>> get cart => _cart;
  bool get hasActiveOrders => _orders.any((o) => o.status == 'DRIVER_ASSIGNED' || o.status == 'IN_TRANSIT');

  double get cartTotal => _cart.fold(0.0, (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int));

  void addToCart(Map<String, dynamic> item) {
    final existing = _cart.indexWhere((i) => i['id'] == item['id']);
    if (existing >= 0) {
      _cart[existing]['quantity'] = (_cart[existing]['quantity'] as int) + 1;
    } else {
      _cart.add({...item, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cart.removeWhere((i) => i['id'] == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final idx = _cart.indexWhere((i) => i['id'] == itemId);
    if (idx >= 0) {
      if (quantity <= 0) {
        _cart.removeAt(idx);
      } else {
        _cart[idx]['quantity'] = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  AppOrder placeOrder(String merchantId, String merchantName, String merchantImage) {
    final order = AppOrder(
      id: 'NEX-${(_orders.length + 1).toString().padLeft(4, '0')}',
      merchantId: merchantId,
      merchantName: merchantName,
      merchantImage: merchantImage,
      items: _cart.map((item) => OrderItem(
        id: item['id'] as String,
        name: item['name'] as String,
        price: (item['price'] as num).toDouble(),
        quantity: item['quantity'] as int,
      )).toList(),
      total: cartTotal,
      status: 'CONFIRMED',
      createdAt: DateTime.now().toIso8601String(),
    );
    _orders.insert(0, order);
    _cart.clear();
    notifyListeners();
    return order;
  }

  void updateOrderStatus(String orderId, String status) {
    final idx = _orders.indexWhere((o) => o.id == orderId);
    if (idx >= 0) {
      _orders[idx] = AppOrder(
        id: _orders[idx].id,
        merchantId: _orders[idx].merchantId,
        merchantName: _orders[idx].merchantName,
        merchantImage: _orders[idx].merchantImage,
        items: _orders[idx].items,
        total: _orders[idx].total,
        status: status,
        createdAt: _orders[idx].createdAt,
      );
      notifyListeners();
    }
  }
}
