import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/models/products.dart';
import 'package:shoping_flutter/utils/app_routes.dart';

import '../models/products_list.dart';

class ProductItemComponent extends StatelessWidget {
  const ProductItemComponent({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoute.PRODUCTFORMESCREEN,
                      arguments: product);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text("Deseja Excluir"),
                          content: const Text(
                              "Ao confirmar a solicitação o produto"
                                  " sera excluido da base de dados "),
                          actions: [
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("não")),
                                TextButton(
                                    onPressed: () => {
                                          Navigator.of(context).pop(),
                                          Provider.of<ProductsList>(context,
                                                  listen: false)
                                              .removeProduct(product),
                                        },
                                    child: const Text("Sim"))
                              ],
                            )
                          ],
                        )),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ))
          ],
        ),
      ),
    );
  }
}
