import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/order_widget.dart';

import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: orders.lenght == 0
          ? Center(
              child: Text("No orders yet"),
            )
          : ListView.builder(
              itemCount: orders.lenght,
              itemBuilder: (_, idx) {
                return OrderWidget(orders.items[idx], idx);
              },
            ),
    );
  }
}
