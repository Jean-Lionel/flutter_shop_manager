import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/product.dart';
import 'package:flutter_shop_manager/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Consumer<Product>(
                builder: (context, product, child) => Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
              onPressed: () {
                product.togleFavoriteStatus();
              },
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
