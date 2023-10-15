import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/components/app_drawer.dart';
import 'package:shoping_flutter/components/product_item_component.dart';
import 'package:shoping_flutter/models/products_list.dart';
import 'package:shoping_flutter/utils/app_routes.dart';

class ProductScreenPage extends StatelessWidget {
  const ProductScreenPage({super.key});

  Future<void> _refreshProduct(BuildContext context) {
    return Provider.of<ProductsList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsList productsList = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoute.PRODUCTFORMESCREEN);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: productsList.itemsCount,
            itemBuilder: (ctx, index) => Column(
              children: [
                ProductItemComponent(
                  product: productsList.items[index],
                ),
                const Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
