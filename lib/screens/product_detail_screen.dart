import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product_detail";

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello $productId'),
      ),
      body: Text("Good"),
    );
  }
}
