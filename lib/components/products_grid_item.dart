import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/auth.provider.dart';
import 'package:shoping_flutter/models/cart.dart';
import 'package:shoping_flutter/models/products.dart';
import 'package:shoping_flutter/utils/app_routes.dart';

class ProductsGridItem extends StatelessWidget {
  const ProductsGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () {
              product.toggleFavorite(auth.token ?? '', auth.uid ?? '');
            },
            icon: Icon(
              product.isfavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
          trailing: IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Produto adicionado com Sucesso!"),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: "DESFAZER",
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
              cart.addItem(product);
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
          backgroundColor: Colors.black54,
        ),
        child: GestureDetector(
          child: Hero(
            tag: "Image-Tag${product.id}",
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoute.PRODUCT_DETAILS, arguments: product);
          },
        ),
      ),
    );
  }
}
