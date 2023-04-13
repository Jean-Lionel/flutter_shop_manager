import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cart;
  final String productId;
  const CartItemWidget(this.cart, this.productId);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      key: ValueKey(cart.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctxt) => AlertDialog(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(Icons.warning),
                        Text("Are you sure ? "),
                      ]),
                  content: Text("Do you want to delete"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctxt).pop(false);
                        },
                        child: Text("No")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctxt).pop(true);
                        },
                        child: Text("Yes")),
                  ],
                ));
      },
      child: Card(
        margin: EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text("${cart.price}"),
              ),
            ),
          ),
          title: Text("${cart.title}"),
          subtitle: Text("Qté : ${cart.quantity} "),
          trailing: Text(
            "Total : ${cart.quantity * cart.price}",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
