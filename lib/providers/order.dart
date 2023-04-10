import 'package:flutter/material.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> product;
  final DateTime dateTime;

  OrderItem(
    this.id,
    this.amount,
    this.product,
    this.dateTime,
  );
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> items, double totalAmount) {
    _items.insert(
        0,
        OrderItem(
          DateTime.now().toString(),
          totalAmount,
          items,
          DateTime.now(),
        ));
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
