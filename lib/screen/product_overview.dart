import 'package:flutter/material.dart';

import '../widgets/product_grid_overview.dart';

enum FilterOption { FAV, ALL }

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFav = false;

  void toogleFav(bool newVal) {
    setState(() {
      _showFav = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text("Only Favourite"), value: FilterOption.FAV),
              PopupMenuItem(child: Text("Show All"), value: FilterOption.ALL)
            ],
            onSelected: (FilterOption selected) {
              if (selected == FilterOption.FAV) {
                toogleFav(true);
              } else {
                toogleFav(false);
              }
            },
          )
        ],
      ),
      body: ProductGrid(_showFav),
    );
  }
}
