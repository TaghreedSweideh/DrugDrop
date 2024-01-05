import 'cart_item_model.dart';

class OrderItemModel{
  final int id;
  final int total;
  final String status;
  final bool isPaid;
  final String dateTime;
  List<CartItemModel> products;

  OrderItemModel({
    required this.id,
    required this.total,

    required this.status,
    required this.isPaid,
    required this.products,
    required this.dateTime,
});
}