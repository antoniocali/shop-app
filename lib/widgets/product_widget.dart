import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/product_detail.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Product _product = Provider.of<Product>(context);
    final Cart _cart = Provider.of<Cart>(context, listen: false);
    final ScaffoldState _scaffold = Scaffold.of(context);

    const Radius _radius = Radius.circular(10);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: _product,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: _radius, topLeft: _radius, topRight: _radius),
        child: GridTile(
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            leading: IconButton(
              icon:
                  Icon(_product.isFav ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  await _product.toggleFav();
                } catch (error) {
                  _scaffold.showSnackBar(SnackBar(
                    content: Text("Error fav the item"),
                  ));
                }
              },
              color: _theme.accentColor,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                _cart.addItem(_product.id, _product.title, _product.price);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Added ${_product.title} to cart"),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () => _cart.removeItem(_product.id),
                    ),
                  ),
                );
              },
              color: _theme.accentColor,
            ),
            title: Text(
              _product.title,
              textAlign: TextAlign.center,
            ),
            subtitle: Text(_product.description),
            backgroundColor: Colors.black87,
          ),
        ),
      ),
    );
  }
}
