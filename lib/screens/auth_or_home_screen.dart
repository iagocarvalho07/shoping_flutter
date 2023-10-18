import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/auth.provider.dart';
import 'package:shoping_flutter/screens/auth_screen.dart';
import 'package:shoping_flutter/screens/products_over_view.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Auth authProvider = Provider.of(context);
    return FutureBuilder(
      future: authProvider.tryAutoLogin(),
      builder: (ct, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text("Ocorreu um erro"),
          );
        } else {
          return authProvider.isAuth ? const ProductsOverViewScreen() : const AuthScreen();
        }
      },
    );
  }
}
