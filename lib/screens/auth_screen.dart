import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoping_flutter/components/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(215, 117, 255, 0.5),
              Color.fromRGBO(255, 188, 117, 0.9)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 70,
                  ),
                  // cascade operator  (..)trans
                  transform: Matrix4.rotationZ(-8 * pi / 180),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange.shade900,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                        )
                      ]),
                  child: Text(
                    "Minha Loja",
                    style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'Anton',
                        color: Theme.of(context).textTheme.titleMedium?.color),
                  ),
                ),
                AuthForm()
              ],
            ),
          )
        ],
      ),
    );
  }
}
