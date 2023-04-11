import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItem;
  const OrderItemWidget(this.orderItem);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _is_expended = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("Total : ${widget.orderItem.amount} BIF"),
            subtitle: Text(
              DateFormat(" dd/MM/yyyy à hh:mm")
                  .format(widget.orderItem.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_is_expended ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _is_expended = !_is_expended;
                });
              },
            ),
          ),
          if (_is_expended)
            Container(
              height: min(widget.orderItem.product.length * 20.0 + 20, 180),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: ListView(
                children: widget.orderItem.product
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("${e.quantity} x ${e.price} BIF",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
      
    );
  }
}
