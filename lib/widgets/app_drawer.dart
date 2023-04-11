import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            title: Text("Hello "),
          ),
          ListTile(
            trailing: Text("Hello world"),
          )
        ],
      ),
    );
  }
}
