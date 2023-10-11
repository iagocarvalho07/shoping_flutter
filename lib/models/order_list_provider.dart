import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoping_flutter/models/cart.dart';

import 'order.dart';

class OrderListProvider with ChangeNotifier {
  List<Order> _Items = [];

  List<Order> get items {
    return [..._Items];
  }

  int get itemsCount {
    return _Items.length;
  }

  void addOrder(Cart cart) {
    _Items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.item.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
