import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/models/http_url.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> togleFavoriteStatus() async {
    final url = Uri.https(HttpUrl.URL, "products/$id.json");
    try {
      final response =
          await http.patch(url, body: json.encode({"favorites": !isFavorite}));
      isFavorite = !isFavorite;
      notifyListeners();
    } catch (e) {
      isFavorite = !isFavorite;
      print("Error: ${e}");
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite
      };
}
