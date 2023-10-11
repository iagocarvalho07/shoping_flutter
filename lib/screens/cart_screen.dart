import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/components/cart_item_component.dart';
import 'package:shoping_flutter/models/order_list_provider.dart';

import '../models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.item.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "total: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text("R\$${cart.totalAmount}",
                        style: Theme.of(context).primaryTextTheme.titleMedium!),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderListProvider>(context, listen: false).addOrder(cart);
                      cart.clear();
                    },
                    child: const Text(
                      "Comprar",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) =>
                  CartItemComponent(cartItem: items[index]),
            ),
          ),
        ],
      ),
    );
  }
}
