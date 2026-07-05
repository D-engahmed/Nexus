const users = [
  { id: 'u1', email: 'customer@nexus.com', password: '123456', name: 'Omar Youssef', phone: '+201000000001', role: 'customer', photo: 'https://i.pravatar.cc/150?u=customer', address: '42 Nile St, Garden City' },
  { id: 'u2', email: 'demo@nexus.com', password: 'demo', name: 'Demo User', phone: '+201000000002', role: 'customer', photo: 'https://i.pravatar.cc/150?u=demo', address: '15 Tahrir Sq, Downtown' },
];

const drivers = [
  { id: 'd1', email: 'driver@nexus.com', password: '123456', name: 'Ahmed Hassan', phone: '+201001234567', role: 'driver', photo: 'https://i.pravatar.cc/150?u=driver1', vehicle: 'Toyota Corolla · ABC 1234', rating: 4.8, lat: 30.045, lng: 31.236 },
  { id: 'd2', email: 'driver2@nexus.com', password: '123456', name: 'Mohamed Ali', phone: '+201009876543', role: 'driver', photo: 'https://i.pravatar.cc/150?u=driver2', vehicle: 'Honda Civic · XYZ 5678', rating: 4.6, lat: 30.050, lng: 31.238 },
  { id: 'd3', email: 'driver3@nexus.com', password: '123456', name: 'Sara Ibrahim', phone: '+201005566778', role: 'driver', photo: 'https://i.pravatar.cc/150?u=driver3', vehicle: 'Kia Rio · DEF 9012', rating: 4.9, lat: 30.048, lng: 31.240 },
];

const merchants = [
  { id: 'm1', name: 'Pizza Roma', cuisine: 'Italian', rating: 4.5, image: 'https://picsum.photos/seed/pizza/200/200', deliveryTime: '25-35', minOrder: 20.0, distance: '1.2 km', lat: 30.0444, lng: 31.2357 },
  { id: 'm2', name: 'Sushi Master', cuisine: 'Japanese', rating: 4.7, image: 'https://picsum.photos/seed/sushi/200/200', deliveryTime: '20-30', minOrder: 30.0, distance: '0.8 km', lat: 30.0520, lng: 31.2400 },
  { id: 'm3', name: 'Burger House', cuisine: 'American', rating: 4.3, image: 'https://picsum.photos/seed/burger/200/200', deliveryTime: '15-25', minOrder: 15.0, distance: '1.5 km', lat: 30.0480, lng: 31.2300 },
  { id: 'm4', name: 'Kebab Corner', cuisine: 'Turkish', rating: 4.6, image: 'https://picsum.photos/seed/kebab/200/200', deliveryTime: '20-30', minOrder: 25.0, distance: '2.1 km', lat: 30.0460, lng: 31.2450 },
  { id: 'm5', name: 'Sweet Treats', cuisine: 'Desserts', rating: 4.8, image: 'https://picsum.photos/seed/dessert/200/200', deliveryTime: '10-20', minOrder: 10.0, distance: '0.5 km', lat: 30.0600, lng: 31.2500 },
  { id: 'm6', name: 'Noodle House', cuisine: 'Chinese', rating: 4.4, image: 'https://picsum.photos/seed/noodle/200/200', deliveryTime: '20-30', minOrder: 20.0, distance: '1.8 km', lat: 30.0550, lng: 31.2380 },
];

const menus = {
  m1: [
    { id: 'i1', name: 'Margherita Pizza', price: 45.0, category: 'Pizza', image: 'https://picsum.photos/seed/margherita/100/100' },
    { id: 'i2', name: 'Pepperoni Pizza', price: 55.0, category: 'Pizza', image: 'https://picsum.photos/seed/pep/100/100' },
    { id: 'i3', name: 'Caesar Salad', price: 30.0, category: 'Salads', image: 'https://picsum.photos/seed/caesar/100/100' },
    { id: 'i4', name: 'Pasta Carbonara', price: 50.0, category: 'Pasta', image: 'https://picsum.photos/seed/carbonara/100/100' },
    { id: 'i5', name: 'Garlic Bread', price: 20.0, category: 'Sides', image: 'https://picsum.photos/seed/garlic/100/100' },
    { id: 'i6', name: 'Coca Cola', price: 10.0, category: 'Drinks', image: 'https://picsum.photos/seed/cola/100/100' },
  ],
  m2: [
    { id: 'i7', name: 'Salmon Nigiri (4pc)', price: 65.0, category: 'Nigiri', image: 'https://picsum.photos/seed/salmon/100/100' },
    { id: 'i8', name: 'California Roll (8pc)', price: 45.0, category: 'Rolls', image: 'https://picsum.photos/seed/cali/100/100' },
    { id: 'i9', name: 'Miso Soup', price: 20.0, category: 'Soup', image: 'https://picsum.photos/seed/miso/100/100' },
    { id: 'i10', name: 'Edamame', price: 25.0, category: 'Appetizers', image: 'https://picsum.photos/seed/edamame/100/100' },
    { id: 'i11', name: 'Green Tea', price: 15.0, category: 'Drinks', image: 'https://picsum.photos/seed/greentea/100/100' },
  ],
  m3: [
    { id: 'i12', name: 'Classic Beef Burger', price: 40.0, category: 'Burgers', image: 'https://picsum.photos/seed/beef/100/100' },
    { id: 'i13', name: 'Chicken Crispy Burger', price: 38.0, category: 'Burgers', image: 'https://picsum.photos/seed/chicken/100/100' },
    { id: 'i14', name: 'French Fries', price: 15.0, category: 'Sides', image: 'https://picsum.photos/seed/fries/100/100' },
    { id: 'i15', name: 'Onion Rings', price: 18.0, category: 'Sides', image: 'https://picsum.photos/seed/onion/100/100' },
  ],
  m4: [
    { id: 'i16', name: 'Beef Kebab Plate', price: 60.0, category: 'Grill', image: 'https://picsum.photos/seed/kebab/100/100' },
    { id: 'i17', name: 'Chicken Shawarma', price: 35.0, category: 'Sandwiches', image: 'https://picsum.photos/seed/shawarma/100/100' },
    { id: 'i18', name: 'Hummus', price: 15.0, category: 'Appetizers', image: 'https://picsum.photos/seed/hummus/100/100' },
    { id: 'i19', name: 'Fattoush Salad', price: 25.0, category: 'Salads', image: 'https://picsum.photos/seed/fattoush/100/100' },
  ],
  m5: [
    { id: 'i20', name: 'Chocolate Cake Slice', price: 25.0, category: 'Cakes', image: 'https://picsum.photos/seed/cake/100/100' },
    { id: 'i21', name: 'Ice Cream Scoop', price: 12.0, category: 'Ice Cream', image: 'https://picsum.photos/seed/icecream/100/100' },
    { id: 'i22', name: 'Waffle with Honey', price: 30.0, category: 'Waffles', image: 'https://picsum.photos/seed/waffle/100/100' },
    { id: 'i23', name: 'Baklava (4pc)', price: 20.0, category: 'Pastries', image: 'https://picsum.photos/seed/baklava/100/100' },
  ],
  m6: [
    { id: 'i24', name: 'Chow Mein', price: 42.0, category: 'Noodles', image: 'https://picsum.photos/seed/chowmein/100/100' },
    { id: 'i25', name: 'Kung Pao Chicken', price: 48.0, category: 'Chicken', image: 'https://picsum.photos/seed/kungpao/100/100' },
    { id: 'i26', name: 'Spring Rolls (4pc)', price: 22.0, category: 'Appetizers', image: 'https://picsum.photos/seed/spring/100/100' },
    { id: 'i27', name: 'Fried Rice', price: 35.0, category: 'Rice', image: 'https://picsum.photos/seed/friedrice/100/100' },
  ],
};

let orders = [];
let orderCounter = 0;

const customerPos = { lat: 30.0626, lng: 31.2497 };

module.exports = { users, drivers, merchants, menus, orders, orderCounter, customerPos };
