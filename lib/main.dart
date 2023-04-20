import 'package:flutter/material.dart';
import './providers/auth.dart';
import './screens/add_product_screen.dart';
import './screens/auth_screen.dart';
import './screens/user_product_screen.dart';
import './screens/order_screen.dart';
import '../providers/order.dart';
import './screens/carte_screen.dart';
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
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products("", []),
          update: (_, auth, previewsProducs) =>
              Products(auth.token as String, previewsProducs!.item),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Order(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
        title: "My SHop",
        theme: ThemeData(
          primaryColor: Colors.purple,
          secondaryHeaderColor: Colors.orange,
          fontFamily: "Lato",
        ),
        home: Scaffold(
            body: auth.isAuth ? ProductVeiwScreen() : AuthScreen(),
        ),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
          OrderScreen.routeName: (_) => OrderScreen(),
          UserProductScreen.routeName: (_) => UserProductScreen(),
          AddProductScreen.routeName: (_) => AddProductScreen(),
          AuthScreen.routeName: (_) => AuthScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
      ),
    );
  }
}