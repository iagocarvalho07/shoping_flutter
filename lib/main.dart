import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/auth.provider.dart';
import 'package:shoping_flutter/models/order_list_provider.dart';
import 'package:shoping_flutter/models/products_list.dart';
import 'package:shoping_flutter/screens/Product_from_Screen.dart';
import 'package:shoping_flutter/screens/auth_or_home_screen.dart';
import 'package:shoping_flutter/screens/cart_screen.dart';
import 'package:shoping_flutter/screens/orders_screen.dart';
import 'package:shoping_flutter/screens/product_screen_page.dart';
import 'package:shoping_flutter/screens/products_details_screen.dart';
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
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductsList>(
          create: (_) => ProductsList('', []),
          update: (ctx, auth, previous) {
            return ProductsList(
              auth.token ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderListProvider>(
          create: (_) => OrderListProvider('', []),
          update: (ctx, auth, previus) {
            return OrderListProvider(
              auth.token ?? '',
              previus?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
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
          AppRoute.AuthOrHomeScreen: (ctx) => AuthOrHomeScreen(),
          AppRoute.PRODUCT_DETAILS: (ctx) => const ProductsDetailsScreen(),
          AppRoute.CART_SCREEN: (ctx) => CartScreen(),
          AppRoute.ORDERS: (ctx) => OdersScreen(),
          AppRoute.PRODUCTSSCRENPAGE: (ctx) => ProductScreenPage(),
          AppRoute.PRODUCTFORMESCREEN: (ctx) => ProductFormScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
