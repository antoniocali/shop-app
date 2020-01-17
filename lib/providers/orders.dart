import 'package:flutter/material.dart';
import '../providers/cart.dart' show CartItem;

class Order {
  final String id;
  final double price;
  final DateTime time;
  final List<CartItem> items;

  Order(
      {@required this.id,
      @required this.price,
      @required this.time,
      @required this.items});
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get items {
    return [..._orders];
  }

  int get lenght {
    return _orders.length;
  }
  
  void addOrder(
      {@required List<CartItem> items,
      @required double price,
      @required DateTime date}) {
    _orders.add(
      Order(
        id: date.toString(),
        price: price,
        items: items,
        time: date,
      ),
    );
    notifyListeners();
  }
}
