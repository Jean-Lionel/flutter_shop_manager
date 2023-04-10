import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;
  const OrderItemWidget(this.orderItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Total : ${orderItem.amount} BIF"),
        subtitle: Text(
          DateFormat(" dd/MM/yyyy à hh:mm").format(orderItem.dateTime),
        ),
        trailing: IconButton(
          icon: Icon(Icons.expand_circle_down),
          onPressed: () {},
        ),
      ),
    );
  }
}
