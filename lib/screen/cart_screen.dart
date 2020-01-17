import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Cart _cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(top:16, left: 16, right: 16, bottom: 5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Chip(
                    label: Text(
                      "${_cart.totalAmount.toStringAsFixed(2)}\$",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _theme.accentColor,
                  ),
                  FlatButton(
                    splashColor: _theme.accentColor.withAlpha(100),
                    colorBrightness: Brightness.light,
                    textColor: _theme.accentColor,
                    child: Text(
                      "ORDER NOW",
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (_, idx) {
                return CartItemWidget(_cart.values[idx], _cart.items.keys.toList()[idx]);
              },
            ),
          )
        ],
      ),
    );
  }
}
