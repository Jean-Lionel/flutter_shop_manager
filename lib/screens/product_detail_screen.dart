import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_shop_manager/models/product.dart';
import 'package:flutter_shop_manager/providers/product.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = "/product_detail";

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    Product product = Provider.of<Products>(context).getProductById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${product.title}'),
      ),
      body: Text("Good"),
    );
  }
}
