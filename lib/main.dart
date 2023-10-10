import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/products_list.dart';
import 'package:shoping_flutter/screens/products_details_screen.dart';
import 'package:shoping_flutter/screens/products_over_view.dart';
import 'package:shoping_flutter/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsList(),
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
          AppRoute.PRODUCT_DETAILS: (ctx) => ProductsDetailsScreen()
        },
        home: ProductsOverViewScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
