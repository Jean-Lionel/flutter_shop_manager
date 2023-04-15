import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _item = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'KOSTUME',
    //   description: 'Gura Costume man ',
    //   price: 49.99,
    //   imageUrl:
    //       'https://fastly.picsum.photos/id/856/300/300.jpg?hmac=K6AeHs9gpB-QHPd5KecDYgrBll0Lq6Lh6nb_nsH2Cic',
    // ),
  ];

  List<Product> get item {
    return [..._item];
  }

  List<Product> get favoritesProducts {
    return _item.where((p) => p.isFavorite).toList();
  }

  Future<void> getAddSyncData() async {
    final url = Uri.https(
        "flutter-first-1d441-default-rtdb.firebaseio.com", "products.json");
    try {
      final response = await http.get(url);

      final result = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> resultList = [];
      result.forEach((productId, productData) {
        resultList.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['favorites'],
        ));
      });

      _item = resultList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addItem(Product v) async {
    final url = Uri.https(
        "flutter-first-1d441-default-rtdb.firebaseio.com", "products.json");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'id': v.id,
            'title': v.title,
            'description': v.description,
            'price': v.price,
            'imageUrl': v.imageUrl,
            'favorites': v.isFavorite
          },
        ),
      );

      v.id = json.decode(response.body)["name"];
      _item.add(v);
      notifyListeners();
    } catch (e) {
      print("Error: ${e}");
      rethrow;
    }
  }

  Future<void> updateProduct(String productId, Product v) async {
    final prodIndex = _item.indexWhere((e) => e.id == productId);
    if (prodIndex >= 0) {
      final url = Uri.https("flutter-first-1d441-default-rtdb.firebaseio.com",
          "products/$productId.json");

      try {
        await http.patch(
          url,
          body: json.encode(
            {
              'title': v.title,
              'description': v.description,
              'price': v.price,
              'imageUrl': v.imageUrl,
              'favorites': v.isFavorite
            },
          ),
        );
      } catch (e) {
        rethrow;
      }

      _item[prodIndex] = v;
    } else {
      addItem(v);
    }
    notifyListeners();
    return Future.value();
  }

  void removeItem(String productId) {
    _item.removeWhere((p) => p.id == productId);
    notifyListeners();
  }

  Product findById(id) {
    return _item.firstWhere((element) => element.id == id);
  }
}
