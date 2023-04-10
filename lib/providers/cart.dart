import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get countItem {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, value) {
      total += (value.price * value.quantity);
    });

    return total;
  }

  void addItems(productId, title, price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: (existingItem.quantity + 1),
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: new DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );

      notifyListeners();
    }
  }
}
