import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  static const _baseUrl = 'https://flutter-base-d18ec.firebaseio.com/products';
  static const _url = _baseUrl + ".json";

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
          imageUrl: value['imageUrl'],
          isFav: value['isFav']
          );
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
    if (id == null) {
      final response = await http.post(_url,
          body: json.encode({
            'title': title,
            'description': description,
            'price': double.parse(price),
            'imageUrl': imageUrl,
            'isFav': false
          }));
      final Product _newProduct = Product(
          id: json.decode(response.body)['name'],
          price: double.parse(price),
          description: description,
          title: title,
          imageUrl: imageUrl,
          isFav: false);
      _items.add(_newProduct);
    } else {
      final Product _newProduct = Product(
          id: id,
          price: double.parse(price),
          description: description,
          title: title,
          imageUrl: imageUrl);
      int _index = _items.indexWhere((elem) => elem.id == id);
      if (_index >= 0) {
        _newProduct.isFav = _items[_index].isFav;
        _items[_index] = _newProduct;
      }
      final String _updateUrl = _baseUrl + "/$id.json";
      http.patch(
        _updateUrl,
        body: json.encode(
          {
            'title': title,
            'description': description,
            'imageUrl': imageUrl,
            'price': double.parse(price)
          },
        ),
      );
    }
    notifyListeners();
  }

  Future<void> deleteItem(Product _product) async {
    final String _deleteUrl = _baseUrl + "/${_product.id}.json";
    if (_items.contains(_product)) {
      var tmpProduct = _product;
      final idx = _items.indexOf(tmpProduct);
      _items.remove(_product);
      final response = await http.delete(_deleteUrl);
      if (response.statusCode >= 400) {
        _items.insert(idx, tmpProduct);
        notifyListeners();
        throw http.ClientException("Failing to delete");
      }
      tmpProduct = null;
      notifyListeners();
    }
  }
}
