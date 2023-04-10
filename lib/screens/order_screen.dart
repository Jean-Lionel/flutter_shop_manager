import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/order.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item_widget.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = "/order-screen";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Order order = Provider.of<Order>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your orders"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemBuilder: (ctxt, index) => Card(
          child: OrderItemWidget(order.items[index]),
        ),
        itemCount: order.items.length,
      ),
    );
  }
}
