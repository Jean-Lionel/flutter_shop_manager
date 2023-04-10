import 'package:flutter/material.dart';
import 'package:flutter_shop_manager/screens/carte_screen.dart';
import '../providers/cart.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: "My SHop",
        theme: ThemeData(
          primaryColor: Colors.purple,
          secondaryHeaderColor: Colors.orange,
          fontFamily: "Lato",
        ),
        home: Scaffold(
          body: ProductVeiwScreen(),
        ),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}