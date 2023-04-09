import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import '../widgets/grid_view_widget.dart';

class ProductVeiwScreen extends StatelessWidget {

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


