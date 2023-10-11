import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoping_flutter/models/order.dart';

class OrderComponent extends StatefulWidget {
  const OrderComponent({super.key, required this.order});

  final Order order;

  @override
  State<OrderComponent> createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("R\$ ${widget.order.total.toStringAsFixed(2)}"),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: _expanded
                    ? const Icon(Icons.expand_less)
                    : const Icon(Icons.expand_more)),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order.products.length * 25) + 10,
              child: ListView(
                children: widget.order.products.map((e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("${e.quantity} x R\$ ${e.price}", style: const TextStyle(
                        fontSize: 18, color: Colors.grey
                      ),)
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
