import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shoping_flutter/models/cart.dart';
import 'package:shoping_flutter/models/cart_item.dart';
import 'order.dart';

class OrderListProvider with ChangeNotifier {
  final _baseUrlORDERS =
      'https://shop-flutter-fb908-default-rtdb.firebaseio.com';
  List<Order> _Items = [];

  List<Order> get items {
    return [..._Items];
  }

  int get itemsCount {
    return _Items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final future = await post(
      Uri.parse('$_baseUrlORDERS/orders.json'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.item.values
              .map(
                (cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                },
              )
              .toList(),
        },
      ),
    );
    final id = jsonDecode(future.body)['name'];
    _Items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.item.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }

  Future<void> loadOrders() async {
    _Items.clear();

    final getOdersFromFb = await get(
      Uri.parse('$_baseUrlORDERS/orders.json'),
    );
    if (getOdersFromFb.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(getOdersFromFb.body);
    data.forEach((orderId, OrderData) {
      _Items.add(
        Order(
          id: orderId,
          total: OrderData['total'],
          products: (OrderData['products'] as List<dynamic>).map((item) {
            return CarItem(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
          date: DateTime.parse(OrderData['date']),
        ),
      );
    });
    notifyListeners();
  }
}
