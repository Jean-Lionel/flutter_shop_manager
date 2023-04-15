import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/products.dart';
import 'package:flutter_shop_manager/screens/add_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  const UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final _scafolder = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddProductScreen.routeName,
                arguments: product.id,
              );
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext cxt) => AlertDialog(
                  content: Text("Do you want to delete"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(cxt).pop();
                          },
                          child: Text('Non'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await Provider.of<Products>(cxt, listen: false)
                                  .removeItem(product.id);
                            } catch (e) {
                              _scafolder.showSnackBar(SnackBar(
                                content: Text("Error: ${e}"),
                              ));
                            } finally {
                              Navigator.of(cxt).pop();
                            }
                          },
                          child: Text('Ok'),
                          style: ButtonStyle(alignment: Alignment.center),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
          ),
        ]),
      ),
    );
  }
}
