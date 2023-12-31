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
import 'package:shoping_flutter/utils/custom_route.dart';

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
          create: (_) => ProductsList('', '', []),
          update: (ctx, auth, previous) {
            return ProductsList(
              auth.token ?? '',
              auth.uid ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderListProvider>(
          create: (_) => OrderListProvider('', '', []),
          update: (ctx, auth, previus) {
            return OrderListProvider(
              auth.token ?? '',
              auth.uid ?? '',
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
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
            },
          ),
        ),
        routes: {
          AppRoute.AuthOrHomeScreen: (ctx) => const AuthOrHomeScreen(),
          AppRoute.PRODUCT_DETAILS: (ctx) => const ProductsDetailsScreen(),
          AppRoute.CART_SCREEN: (ctx) => const CartScreen(),
          AppRoute.ORDERS: (ctx) => const OdersScreen(),
          AppRoute.PRODUCTSSCRENPAGE: (ctx) => const ProductScreenPage(),
          AppRoute.PRODUCTFORMESCREEN: (ctx) => const ProductFormScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
