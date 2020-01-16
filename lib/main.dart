import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screen/cart_screen.dart';

import './screen/product_detail.dart';
import './screen/product_overview.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: "Lato",
          accentColor: Colors.deepOrangeAccent,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen()
        },
      ),
    );
  }
}
