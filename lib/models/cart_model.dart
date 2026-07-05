import 'package:fruit_store_app/models/fruit_model.dart';

class CartItem {
  final Fruit fruit;
  int quantity;

  CartItem({
    required this.fruit,
    this.quantity = 1,
  });

  double get totalPrice => fruit.price * quantity;
}

class OrderHistory {
  final String id;
  final List<CartItem> items;
  final DateTime orderDate;
  final double totalAmount;
  final String status;

  OrderHistory({
    required this.id,
    required this.items,
    required this.orderDate,
    required this.totalAmount,
    this.status = 'Selesai',
  });
}