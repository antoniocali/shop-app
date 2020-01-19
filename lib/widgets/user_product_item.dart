import 'package:flutter/material.dart';

import '../providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product _product;

  UserProductItem(this._product);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
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
              onPressed: () {},
              color: _theme.primaryColorDark,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: _theme.errorColor,
            )
          ],
        ),
      ),
    );
  }
}
