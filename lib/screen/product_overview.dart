import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screen/cart_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/product_grid_overview.dart';

enum FilterOption { FAV, ALL }

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFav = false;
  bool _init = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_init) {
      _isLoading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _init = true;
    }
    super.didChangeDependencies();
  }

  void toogleFav(bool newVal) {
    setState(() {
      _showFav = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text("MyShop"),
        actions: <Widget>[
          Consumer<Cart>(
              builder: (ctx, _cart, child) {
                return Badge(
                  child: child,
                  value: _cart.length.toString(),
                  color: Colors.red,
                );
              },
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  return Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              )),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favourite"),
                value: FilterOption.FAV,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOption.ALL,
              )
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(_showFav),
    );
  }
}
