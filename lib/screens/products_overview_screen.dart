import 'package:flutter/material.dart';
import '../widgets/product_item.dart';
import '../widgets/grid_view_widget.dart';

enum FilterProduct {
  All,
  Favorites,
}

class ProductVeiwScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: FilterProduct.All,
                      child: Text("All"),
                    ),
                    const PopupMenuItem(
                      value: FilterProduct.Favorites,
                      child: Text("Only Favorite"),
                    ),
                  ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridViewWigdet(),
      ),
    );
  }
}
