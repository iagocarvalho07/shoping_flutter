import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_flutter/components/app_drawer.dart';
import 'package:shoping_flutter/components/order_component.dart';
import 'package:shoping_flutter/models/order_list_provider.dart';

class OdersScreen extends StatefulWidget {
  const OdersScreen({super.key});

  @override
  State<OdersScreen> createState() => _OdersScreenState();
}

class _OdersScreenState extends State<OdersScreen> {
  bool _Isloading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderListProvider>(context, listen: false)
        .loadOrders()
        .then((_) {
      setState(() => _Isloading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderListProvider ordres = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: const AppDrawer(),
      body: _Isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ordres.itemsCount,
              itemBuilder: (ctx, index) =>
                  OrderComponent(order: ordres.items[index])),
    );
  }
}
