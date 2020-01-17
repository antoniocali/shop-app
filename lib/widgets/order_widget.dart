import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  final int idx;
  final DateFormat _dateFormat = DateFormat.MEd();
  OrderWidget(this.order, this.idx);
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: CircleAvatar(
          child: Text("$idx"),
        ),
        key: ValueKey(order.id),
        title: Text(
          _dateFormat.format(order.time),
        ),
        subtitle: Text("${order.price}\$"),
        children: [
          ...order.items
              .map((cartItem) => CartItemMinimalWidget(cartItem))
              .toList(),
          SizedBox(
            height: 20,
          )
        ]);
  }
}
