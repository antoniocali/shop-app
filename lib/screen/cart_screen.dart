import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Cart _cart = Provider.of<Cart>(context);
    final Orders _orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 5),
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
                  OrderButton(
                    theme: _theme,
                    orders: _orders,
                    cart: _cart,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (_, idx) {
                return CartItemWidget(
                    _cart.values[idx], _cart.items.keys.toList()[idx]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required ThemeData theme,
    @required Orders orders,
    @required Cart cart,
  })  : _theme = theme,
        _orders = orders,
        _cart = cart,
        super(key: key);

  final ThemeData _theme;
  final Orders _orders;
  final Cart _cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: widget._theme.accentColor.withAlpha(100),
      colorBrightness: Brightness.light,
      textColor: widget._theme.accentColor,
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              "ORDER NOW",
            ),
      onPressed: (widget._cart.length <= 0 || _isLoading)
          ? null
          : () async {
              try {
                setState(() {
                  _isLoading = true;
                });

                await widget._orders.addOrder(
                    items: widget._cart.values,
                    date: DateTime.now(),
                    price: widget._cart.totalAmount);
                setState(() {
                  _isLoading = false;
                });
                widget._cart.cleanCart();
              } catch (error) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error placing the order"),
                  ),
                );
              }
            },
    );
  }
}
