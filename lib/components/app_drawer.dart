import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/auth.provider.dart';
import 'package:shoping_flutter/utils/app_routes.dart';
import 'package:shoping_flutter/utils/custom_route.dart';

import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text(
              "Bem Vindo Usuario",
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Loja"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoute.AuthOrHomeScreen);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoute.ORDERS);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(builder: (ctx) => const OdersScreen())
              // );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Gerenciar Produtos"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoute.PRODUCTSSCRENPAGE);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Sair"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context)
                  .pushReplacementNamed(AppRoute.AuthOrHomeScreen);
            },
          ),
        ],
      ),
    );
  }
}
