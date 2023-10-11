import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/components/app_drawer.dart';
import 'package:shoping_flutter/components/order_component.dart';
import 'package:shoping_flutter/models/order_list_provider.dart';

class OdersScreen extends StatelessWidget {
  const OdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderListProvider ordres = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: ordres.itemsCount,
          itemBuilder: (ctx, index) =>
              OrderComponent(order: ordres.items[index])),
    );
  }
}
