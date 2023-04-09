import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/widgets/product_item.dart';
import '../models/product.dart';
import '../widgets/grid_view_widget.dart';

class ProductVeiwScreen extends StatelessWidget {
  List<Product> loadProducts = [];
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridViewWigdet(),
      ),
    );
  }
}


