import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products_provider.dart';
import '../screen/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {

  static const String routeName = "/user_product";
  @override
  Widget build(BuildContext context) {
    final Products _products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (ctx, idx) {
            return UserProductItem(_products.items[idx]);
          },
        ),
      ),
    );
  }
}
