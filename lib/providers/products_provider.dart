import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  int get length {
    return _items.length;
  }

  void addItem(String title, String description, String price, String imageUrl,
      String id) {
    final Product _newProduct = Product(
        id: DateTime.now().toString(),
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
