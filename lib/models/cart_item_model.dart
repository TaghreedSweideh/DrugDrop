class CartItemModel {
  final int productId;
  final String title;
  int quantity;
  final int price;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });
}
