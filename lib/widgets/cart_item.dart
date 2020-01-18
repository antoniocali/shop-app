import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemMinimalWidget extends StatelessWidget {
  final CartItem cartItem;
  CartItemMinimalWidget(this.cartItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 2),
      child: ListTile(
        dense: true,
        leading: Chip(label: Text("${cartItem.price.toStringAsFixed(2)}\$")),
        title: Text(cartItem.title),
        subtitle: Text(
            "Total : ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}\$"),
        trailing: Text("${cartItem.quantity} x"),
      ),
    );
  }
}

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
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Are you sure?"),
                content: Text("Do you want to remove the item?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("No"),
                    onPressed: () => Navigator.of(ctx).pop(false),
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () => Navigator.of(ctx).pop(true),
                  )
                ],
              );
            },
          );
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
        child: CartItemMinimalWidget(cartItem));
  }
}
