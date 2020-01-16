import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
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
                    label: Consumer<Cart>(
                      builder: (_, cart, __) => Text(
                        cart.totalAmount.toStringAsFixed(2),
                        style: _theme.primaryTextTheme.title,
                      ),
                    ),
                    backgroundColor: _theme.accentColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
