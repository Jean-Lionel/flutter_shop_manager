import 'package:flutter/material.dart';
import './order_screen.dart';
import '../providers/cart.dart';
import '../providers/order.dart';
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
                      Chip(
                          label:
                              Text("\$ ${cart.totalPrice.toStringAsFixed(2)}")),
                      OrdNowButton(cart: cart)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (cxt, index) => CartItemWidget(
                  cart.items.values.toList()[index],
                  cart.items.keys.toList()[index],
                ),
                itemCount: cart.countItem,
              ))
            ],
          ),
        ));
  }
}

class OrdNowButton extends StatefulWidget {
  const OrdNowButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrdNowButton> createState() => _OrdNowButtonState();
}

class _OrdNowButtonState extends State<OrdNowButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalPrice <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Order>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalPrice);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
      child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
    );
  }
}
