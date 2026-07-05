class MockData {
  static const drivers = [
    {'id': 'd1', 'email': 'driver@nexus.com', 'password': '123456', 'name': 'Ahmed Hassan', 'phone': '+201001234567', 'photo': 'https://i.pravatar.cc/150?u=driver1', 'vehicle': 'Toyota Corolla · ABC 1234', 'rating': 4.8, 'totalDeliveries': 342, 'online': true},
    {'id': 'd2', 'email': 'driver2@nexus.com', 'password': '123456', 'name': 'Mohamed Ali', 'phone': '+201009876543', 'photo': 'https://i.pravatar.cc/150?u=driver2', 'vehicle': 'Honda Civic · XYZ 5678', 'rating': 4.6, 'totalDeliveries': 218, 'online': true},
    {'id': 'd3', 'email': 'driver3@nexus.com', 'password': '123456', 'name': 'Sara Ibrahim', 'phone': '+201005566778', 'photo': 'https://i.pravatar.cc/150?u=driver3', 'vehicle': 'Kia Rio · DEF 9012', 'rating': 4.9, 'totalDeliveries': 501, 'online': true},
  ];

  static const assignedOrders = [
    {
      'id': 'NEX-0001',
      'customerName': 'Omar Youssef',
      'customerPhone': '+201000000001',
      'customerAddress': '42 Nile St, Garden City',
      'customerPhoto': 'https://i.pravatar.cc/150?u=customer',
      'merchantName': 'Pizza Roma',
      'merchantAddress': '15 Tahrir Sq, Downtown',
      'merchantId': 'm1',
      'merchantLat': 30.0444,
      'merchantLng': 31.2357,
      'customerLat': 30.0626,
      'customerLng': 31.2497,
      'items': [
        {'name': 'Margherita Pizza', 'quantity': 1, 'price': 45.0},
        {'name': 'Garlic Bread', 'quantity': 2, 'price': 20.0},
        {'name': 'Coca Cola', 'quantity': 2, 'price': 10.0},
      ],
      'total': 105.0,
      'status': 'PENDING_PICKUP',
      'distance': '1.2 km',
      'pickupTime': '10-15 min',
    },
    {
      'id': 'NEX-0002',
      'customerName': 'Ali Mahmoud',
      'customerPhone': '+201001112233',
      'customerAddress': '8 Zamalek St, Zamalek',
      'customerPhoto': 'https://i.pravatar.cc/150?u=ali',
      'merchantName': 'Sushi Master',
      'merchantAddress': '22 Corniche Rd, Downtown',
      'merchantId': 'm2',
      'merchantLat': 30.0520,
      'merchantLng': 31.2400,
      'customerLat': 30.0700,
      'customerLng': 31.2200,
      'items': [
        {'name': 'California Roll (8pc)', 'quantity': 2, 'price': 45.0},
        {'name': 'Miso Soup', 'quantity': 1, 'price': 20.0},
      ],
      'total': 110.0,
      'status': 'ASSIGNED',
      'distance': '2.5 km',
      'pickupTime': '15-20 min',
    },
  ];

  static const completedDeliveries = [
    {'id': 'DEL-0032', 'date': '2026-07-04', 'merchantName': 'Burger House', 'amount': 38.0, 'tip': 5.0, 'rating': 5, 'customerName': 'Nour Khaled'},
    {'id': 'DEL-0031', 'date': '2026-07-04', 'merchantName': 'Kebab Corner', 'amount': 60.0, 'tip': 8.0, 'rating': 4, 'customerName': 'Layla Hassan'},
    {'id': 'DEL-0030', 'date': '2026-07-04', 'merchantName': 'Sweet Treats', 'amount': 25.0, 'tip': 3.0, 'rating': 5, 'customerName': 'Yassin Ali'},
    {'id': 'DEL-0029', 'date': '2026-07-03', 'merchantName': 'Pizza Roma', 'amount': 55.0, 'tip': 10.0, 'rating': 5, 'customerName': 'Omar Youssef'},
  ];
}
