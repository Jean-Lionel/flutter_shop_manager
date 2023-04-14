import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/screens/add_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = "/add_products";
  const UserProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddProductScreen.routeName,
              );
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productData.item.length,
            itemBuilder: (ctxt, index) =>
                UserProductItem(productData.item[index]),
          )),
    );
  }
}
