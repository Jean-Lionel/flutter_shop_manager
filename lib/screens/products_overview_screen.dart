import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/screens/carte_screen.dart';
import 'package:flutter_shop_manager/widgets/app_drawer.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../widgets/grid_view_widget.dart';
import '../widgets/badge.dart';

enum FilterProduct {
  All,
  Favorites,
}

class ProductVeiwScreen extends StatefulWidget {
  @override
  State<ProductVeiwScreen> createState() => _ProductVeiwScreenState();
}

class _ProductVeiwScreenState extends State<ProductVeiwScreen> {
  bool _showFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
              onSelected: (FilterProduct f) {
                setState(() {
                  if (f == FilterProduct.All) {
                    _showFav = false;
                  } else {
                    _showFav = true;
                  }
                });
              },
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
          Consumer<Cart>(
            builder: (_, cart, ch) => BadgeWidget(
              value: cart.countItem.toString(),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridViewWigdet(_showFav),
      ),
    );
  }
}
