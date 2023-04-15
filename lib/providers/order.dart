import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/models/htt_url.dart';
import 'package:http/http.dart' as http;
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'product': product,
        'dateTime': dateTime,
      };
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  Future<void> addOrder(List<CartItem> items, double totalAmount) async {
    final url = Uri.https(HttpUrl.URL, "orders.json");

    final jsonItems = items.map((e) => e.toJson());
    //print(jsonItems);
    final response = await http.post(url,
        body: json.encode({
          "amount": totalAmount,
          "product": [...jsonItems],
          "dateTime": DateTime.now().toString()
        }));
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
