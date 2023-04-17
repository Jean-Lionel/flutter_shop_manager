import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/http_url.dart';
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

  Future<void> initOrders() async {
    try {
      final url = Uri.https(HttpUrl.URL, "orders.json");
      final response = await http.get(url);
      final result = json.decode(response.body) as Map<String, dynamic>;
      List<OrderItem> resultList = [];
      result.forEach((key, value) {
        if (value["product"] != null) {
          List<dynamic> x = List.from(value["product"]);

          List<CartItem> productList = [];

          x.forEach((e) {
            productList.add(CartItem(
              id: e["id"],
              title: e["title"],
              price: e["price"],
              quantity: e["quantity"],
            ));
          });

          resultList.add(OrderItem(
            key,
            value["amount"],
            productList,
            DateTime.parse(value["dateTime"]),
          ));
        }
      });
      _items = resultList;
      notifyListeners();
    } catch (e) {
      print("Error ${e}");
    }
  }

  Future<void> addOrder(List<CartItem> items, double totalAmount) async {
    //print(jsonItems);
    try {
      final url = Uri.https(HttpUrl.URL, "orders.json");
      final jsonItems = items.map((e) => e.toJson());
      DateTime time = DateTime.now();
      final response = await http.post(url,
          body: json.encode({
            "amount": totalAmount,
            "product": [...jsonItems],
            "dateTime": time.toIso8601String()
          }));
      _items.insert(
          0,
          OrderItem(
            json.decode(response.body)["name"],
            totalAmount,
            items,
            time,
          ));
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
