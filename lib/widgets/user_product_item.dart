import 'package:flutter/material.dart';
import '../providers/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;
  const UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {},
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
                          onPressed: () {},
                          child: Text('Non'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
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
