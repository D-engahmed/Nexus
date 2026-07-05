class MockData {
  static const categories = [
    {'id': 'cat1', 'name': 'Groceries', 'icon': '🛒', 'color': '#E8F5E9'},
    {'id': 'cat2', 'name': 'Pharmacy', 'icon': '💊', 'color': '#FFF3E0'},
    {'id': 'cat3', 'name': 'Drinks', 'icon': '🍹', 'color': '#E3F2FD'},
    {'id': 'cat4', 'name': 'Gifts', 'icon': '🎁', 'color': '#FCE4EC'},
    {'id': 'cat5', 'name': 'Food', 'icon': '🍔', 'color': '#FFF8E1'},
    {'id': 'cat6', 'name': 'Fashion', 'icon': '👗', 'color': '#F3E5F5'},
  ];

  static const merchants = [
    {
      'id': 'm1', 'name': 'Pizza Roma', 'cuisine': 'Italian',
      'rating': 4.5, 'image': 'https://picsum.photos/seed/pizza/400/300',
      'deliveryTime': '25-35', 'minOrder': 20.0, 'distance': '1.2 km',
      'deliveryFee': 0.99, 'lat': 30.0444, 'lng': 31.2357,
      'badge': 'FASTEST', 'featured': true, 'promoted': true,
    },
    {
      'id': 'm2', 'name': 'Sushi Master', 'cuisine': 'Japanese',
      'rating': 4.7, 'image': 'https://picsum.photos/seed/sushi/400/300',
      'deliveryTime': '20-30', 'minOrder': 30.0, 'distance': '0.8 km',
      'deliveryFee': 1.49, 'lat': 30.0520, 'lng': 31.2400,
      'badge': '', 'featured': true, 'promoted': false,
    },
    {
      'id': 'm3', 'name': 'Burger House', 'cuisine': 'American',
      'rating': 4.3, 'image': 'https://picsum.photos/seed/burger/400/300',
      'deliveryTime': '15-25', 'minOrder': 15.0, 'distance': '1.5 km',
      'deliveryFee': 0.0, 'lat': 30.0480, 'lng': 31.2300,
      'badge': '', 'featured': false, 'promoted': false,
    },
    {
      'id': 'm4', 'name': 'Kebab Corner', 'cuisine': 'Turkish',
      'rating': 4.6, 'image': 'https://picsum.photos/seed/kebab/400/300',
      'deliveryTime': '20-30', 'minOrder': 25.0, 'distance': '2.1 km',
      'deliveryFee': 1.99, 'lat': 30.0460, 'lng': 31.2450,
      'badge': '', 'featured': true, 'promoted': false,
    },
    {
      'id': 'm5', 'name': 'Sweet Treats', 'cuisine': 'Desserts',
      'rating': 4.8, 'image': 'https://picsum.photos/seed/dessert/400/300',
      'deliveryTime': '10-20', 'minOrder': 10.0, 'distance': '0.5 km',
      'deliveryFee': 0.49, 'lat': 30.0600, 'lng': 31.2500,
      'badge': 'FASTEST', 'featured': true, 'promoted': false,
    },
    {
      'id': 'm6', 'name': 'Noodle House', 'cuisine': 'Chinese',
      'rating': 4.4, 'image': 'https://picsum.photos/seed/noodle/400/300',
      'deliveryTime': '20-30', 'minOrder': 20.0, 'distance': '1.8 km',
      'deliveryFee': 1.29, 'lat': 30.0550, 'lng': 31.2380,
      'badge': '', 'featured': false, 'promoted': false,
    },
  ];

  static const menus = {
    'm1': [
      {'id': 'i1', 'name': 'Margherita Pizza', 'price': 45.0, 'category': 'Popular Items', 'description': 'Fresh mozzarella, tomato sauce, basil on hand-tossed dough', 'image': 'https://picsum.photos/seed/margherita/200/200', 'badge': ''},
      {'id': 'i2', 'name': 'Pepperoni Pizza', 'price': 55.0, 'category': 'Popular Items', 'description': 'Loaded with premium pepperoni and melted cheese', 'image': 'https://picsum.photos/seed/pep/200/200', 'badge': ''},
      {'id': 'i3', 'name': 'Caesar Salad', 'price': 30.0, 'category': 'Sides & Snacks', 'description': 'Crispy romaine, parmesan, croutons, caesar dressing', 'image': 'https://picsum.photos/seed/caesar/200/200', 'badge': ''},
      {'id': 'i4', 'name': 'Pasta Carbonara', 'price': 50.0, 'category': 'Popular Items', 'description': 'Creamy pasta with pancetta, egg, parmesan', 'image': 'https://picsum.photos/seed/carbonara/200/200', 'badge': 'PROMOTED'},
      {'id': 'i5', 'name': 'Garlic Bread', 'price': 20.0, 'category': 'Sides & Snacks', 'description': 'Crispy garlic butter bread with herbs', 'image': 'https://picsum.photos/seed/garlic/200/200', 'badge': ''},
      {'id': 'i6', 'name': 'Coca Cola', 'price': 10.0, 'category': 'Drinks', 'description': 'Chilled 330ml can', 'image': 'https://picsum.photos/seed/cola/200/200', 'badge': ''},
      {'id': 'i7', 'name': 'Pepperoni Combo', 'price': 75.0, 'category': 'Burger Combos', 'description': 'Large pepperoni pizza + garlic bread + 2 drinks', 'image': 'https://picsum.photos/seed/combo/200/200', 'badge': ''},
    ],
    'm2': [
      {'id': 'i8', 'name': 'Salmon Nigiri (4pc)', 'price': 65.0, 'category': 'Popular Items', 'description': 'Fresh Atlantic salmon over seasoned rice', 'image': 'https://picsum.photos/seed/salmon/200/200', 'badge': ''},
      {'id': 'i9', 'name': 'California Roll (8pc)', 'price': 45.0, 'category': 'Popular Items', 'description': 'Crab, avocado, cucumber wrapped in seaweed', 'image': 'https://picsum.photos/seed/cali/200/200', 'badge': ''},
      {'id': 'i10', 'name': 'Miso Soup', 'price': 20.0, 'category': 'Sides & Snacks', 'description': 'Traditional soybean paste soup with tofu', 'image': 'https://picsum.photos/seed/miso/200/200', 'badge': ''},
    ],
  };

  static const users = [
    {'id': 'u1', 'email': 'customer@nexus.com', 'password': '123456', 'name': 'Omar Youssef', 'phone': '+201000000001', 'photo': 'https://i.pravatar.cc/150?u=customer', 'address': '42 Nile St, Garden City', 'wallet': 125.50},
    {'id': 'u2', 'email': 'demo@nexus.com', 'password': 'demo', 'name': 'Demo User', 'phone': '+201000000002', 'photo': 'https://i.pravatar.cc/150?u=demo', 'address': '15 Tahrir Sq, Downtown', 'wallet': 75.00},
  ];
}
