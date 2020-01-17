import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final String productId;
  CartItemWidget(this.cartItem, this.productId);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Cart _cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        _cart.removeItem(productId);
      },
      key: ValueKey(cartItem.id),
      background: Container(
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                " Delete",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
        ),
        color: _theme.errorColor,
      ),
      child: Card(
        margin: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 2),
        child: ListTile(
          dense: true,
          leading: Chip(label: Text("${cartItem.price.toStringAsFixed(2)}\$")),
          title: Text(cartItem.title),
          subtitle: Text(
              "Total : ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}\$"),
          trailing: Text("${cartItem.quantity} x"),
        ),
      ),
    );
  }
}
