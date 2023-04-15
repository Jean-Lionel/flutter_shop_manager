import 'package:flutter/material.dart';

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

  togleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
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
