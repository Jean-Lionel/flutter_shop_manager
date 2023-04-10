import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/providers/products.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class GridViewWigdet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final List<Product> products = productData.item;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctxt, i) => ChangeNotifierProvider(
        create: (_) => products[i],
        child: ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}
