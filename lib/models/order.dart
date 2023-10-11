import 'cart_item.dart';

class Order {
  final String id;
  final double total;
  final List<CarItem> products;
  final DateTime date;

  Order(
      {required this.id,
      required this.total,
      required this.products,
      required this.date});
}
