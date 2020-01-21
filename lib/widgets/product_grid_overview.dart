import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_widget.dart';

class ProductGrid extends StatelessWidget {
  final bool _showFav;
  ProductGrid(this._showFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    productsData.fetchAndSetProducts();
    final products = productsData.items.where((pdx) => !_showFav || pdx.isFav).toList();
    return GridView.builder(
      itemCount: products.length,
      itemBuilder: (context, idx) {
        return ChangeNotifierProvider.value(
          value: products[idx],
          child: ProductItem(),
        );
      },
      padding: const EdgeInsets.all(6),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 6 / 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
      ),
    );
  }
}
