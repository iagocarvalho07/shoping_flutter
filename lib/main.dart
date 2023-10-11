import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/order_list_provider.dart';
import 'package:shoping_flutter/models/products_list.dart';
import 'package:shoping_flutter/screens/cart_screen.dart';
import 'package:shoping_flutter/screens/products_details_screen.dart';
import 'package:shoping_flutter/screens/products_over_view.dart';
import 'package:shoping_flutter/utils/app_routes.dart';

import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderListProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoute.PRODUCT_DETAILS: (ctx) => const ProductsDetailsScreen(),
          AppRoute.CART_SCREEN: (ctx) => CartScreen(),
        },
        home: const ProductsOverViewScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
