import 'package:flutter/material.dart';

import '../screen/user_product.dart';
import '../screen/orders_screen.dart';
import '../screen/product_overview.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              color: _theme.primaryColor,
              height: 200,
              child: Center(
                child: Text(
                  "Shop App",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: 'Anton'),
                ),
              )),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text("User Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
