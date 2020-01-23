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
      body: FutureBuilder(
        future: orders.fetchOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              print(snapshot.error);
              return Center(child: Text("Error fetching orders"));
            } else {
              if (orders.lenght == 0)
                return Center(
                  child: Text("No orders yet"),
                );
              else
                return ListView.builder(
                  itemCount: orders.lenght,
                  itemBuilder: (_, idx) {
                    return OrderWidget(orders.items[idx], idx);
                  },
                );
            }
          }
        },
      ),
    );
  }
}
