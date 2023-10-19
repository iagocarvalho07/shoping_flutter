import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/components/products_grid_item.dart';
import '../models/products.dart';
import '../models/products_list.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.showfavoriteOnly});

  final bool showfavoriteOnly;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsList>(context);
    final List<Product> loadedProduts =
        showfavoriteOnly ? provider.itemsFavorite : provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProduts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: loadedProduts[index],
          child: const ProductsGridItem(),
        );
      },
    );
  }
}
