import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;
  static const _baseUrl = 'https://flutter-base-d18ec.firebaseio.com/products';

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFav = false,
  });

  Future<void> toggleFav() async {
    isFav = !isFav;
    try {
      final response = await http.patch(
        _baseUrl + "/$id.json",
        body: json.encode({'isFav': isFav}),
      );
      if (response.statusCode >= 400) {
        throw http.ClientException("Error occured");
      }
    } catch (error) {
      isFav = !isFav;
      throw error;
    }
    notifyListeners();
  }
}
