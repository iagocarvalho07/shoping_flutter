import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoping_flutter/models/products.dart';

import 'cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CarItem> _items = {};

  Map<String, CarItem> get item {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount{
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) =>
          CarItem(
            id: existingItem.id,
            productId: existingItem.productId,
            name: existingItem.name,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,));
    } else {
      _items.putIfAbsent(product.id, () =>
          CarItem(id: Random().nextDouble().toString(),
            productId: product.id,
            name: product.title,
            quantity: 1,
            price: product.price,));
    }
    notifyListeners();
  }
}