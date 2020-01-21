import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  static const _url = 'https://flutter-base-d18ec.firebaseio.com/products.json';

  Future<void> fetchAndSetProducts() async {
    final products = await http.get(_url);
    _items = (json.decode(products.body) as Map<String, dynamic>)
        .entries
        .map<Product>((item) {
      final id = item.key;
      final value = item.value;
      return Product(
          id: id,
          price: value['price'],
          title: value['title'],
          description: value['description'],
          imageUrl: value['imageUrl']);
    }).toList();
    notifyListeners();
  }

  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  int get length {
    return _items.length;
  }

  Future<void> addItem(String title, String description, String price,
      String imageUrl, String id) async {
    final response = await http.post(_url,
        body: json.encode({
          'title': title,
          'description': description,
          'price': price,
          'imageUrl': imageUrl
        }));

    final Product _newProduct = Product(
        id: json.decode(response.body)['name'],
        price: double.parse(price),
        description: description,
        title: title,
        imageUrl: imageUrl);
    if (id != null) {
      int _index = _items.indexWhere((elem) => elem.id == id);
      if (_index > 0) {
        _newProduct.isFav = _items[_index].isFav;
        _items[_index] = _newProduct;
      }
    } else {
      _items.add(_newProduct);
    }
    notifyListeners();
  }

  void deleteItem(Product _product) {
    if (_items.contains(_product)) {
      _items.remove(_product);
      notifyListeners();
    }
  }
}
