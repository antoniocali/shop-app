import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screen/edit_product_screen.dart';
import '../providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product _product;

  UserProductItem(this._product);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Products _products = Provider.of<Products>(context, listen: false);
    final _scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(_product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: _product);
              },
              color: _theme.primaryColorDark,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await _products.deleteItem(_product);
                } catch (error) {
                  _scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        "Failed to delete",
                      ),
                    ),
                  );
                }
              },
              color: _theme.errorColor,
            )
          ],
        ),
      ),
    );
  }
}
