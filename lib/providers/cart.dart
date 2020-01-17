import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {@required this.id,
      @required this.title,
      this.quantity = 1,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get length {
    return _items.length;
  }

  List<CartItem> get values {
    return [...items.values];
  }

  double get totalAmount {
    return (_items.isEmpty)
        ? 0
        : (_items.values
            .map<double>((item) => (item.price * item.quantity))
            .reduce((_, __) => _ + __));
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      notifyListeners();
    }
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (old) => CartItem(
            id: old.id,
            title: old.title,
            price: old.price,
            quantity: old.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () =>
            CartItem(id: DateTime.now().toString(), title: title, price: price),
      );
    }
    notifyListeners();
  }

  void cleanCart() {
    _items = {};
    notifyListeners();
  }
}
