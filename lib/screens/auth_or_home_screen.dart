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
    return authProvider.isAuth ? ProductsOverViewScreen() : AuthScreen();
  }
}
