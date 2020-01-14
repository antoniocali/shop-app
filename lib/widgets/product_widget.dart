import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product _product;
  ProductItem(this._product);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        _product.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        leading: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
        title: Text(
          _product.title,
          textAlign: TextAlign.center,
        ),
        subtitle: Text(_product.description),
        backgroundColor: Colors.black38,
      ),
    );
  }
}
