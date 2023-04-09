import 'package:flutter/material.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My SHop",
      theme: ThemeData(
        primaryColor: Colors.purple,
        secondaryHeaderColor: Colors.orange,
        fontFamily: "Lato",
      ),
       home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("My Shop"),
        ),
        body: ProductVeiwScreen(),
       ),
      routes: {
        ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
      },
       );
  }
}