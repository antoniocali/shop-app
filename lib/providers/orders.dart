import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  static const _url = 'https://flutter-base-d18ec.firebaseio.com/orders.json';

  List<Order> _orders = [];

  List<Order> get items {
    return [..._orders];
  }

  int get lenght {
    return _orders.length;
  }

  Future<void> fetchOrders() async {
    final response = await http.get(_url);
    if (json.decode(response.body) == null) return;
    _orders = (json.decode(response.body) as Map<String, dynamic>)
        .entries
        .map<Order>((order) {
      final listItems =
          (order.value['items'] as List<dynamic>).map<CartItem>((item) {
        return CartItem(
            id: item['id'],
            price: item['price'],
            title: item['title'],
            quantity: item['quantity']);
      }).toList();
      return Order(
          id: order.key,
          price: order.value['price'],
          items: listItems,
          time: DateTime.parse(order.value['datetime']));
    }).toList();
    notifyListeners();
  }

  Future<void> addOrder(
      {@required List<CartItem> items,
      @required double price,
      @required DateTime date}) async {
    final response = await http.post(_url,
        body: json.encode({
          'price': price,
          'datetime': date.toIso8601String(),
          'items': items.map((elem) {
            return {
              'id': elem.id,
              'quantity': elem.quantity,
              'price': elem.price,
              'title': elem.title
            };
          }).toList()
        }));

    _orders.add(
      Order(
        id: json.decode(response.body)['name'],
        price: price,
        items: items,
        time: date,
      ),
    );
    notifyListeners();
  }
}
