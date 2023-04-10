import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/cart.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item_wiget.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = "/cart-screen";
  const CartScreen();
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart Detail'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Chip(label: Text("\$ ${cart.totalPrice}")),
                      TextButton(
                        onPressed: () {},
                        child: Text("ORDER NOW"),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (cxt, index) => CartItemWidget(),
                itemCount: cart.countItem,
              ))
            ],
          ),
        ));
  }
}
