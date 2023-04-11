import 'package:flutter/material.dart';
import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            title: const Text('Hello world'),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          const Divider(),
          ListTile(
            leading: const Text("Shop"),
            title: const Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Text("Orders"),
            title: const Icon(Icons.payment),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
