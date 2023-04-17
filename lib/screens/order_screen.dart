import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/cart.dart';
import '../providers/order.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item_widget.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = "/order-screen";
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Order>(context, listen: false).initOrders();
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final Order order = Provider.of<Order>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
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
