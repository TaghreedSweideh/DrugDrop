import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart_item_model.dart';
import '../main.dart';

class CartProvider with ChangeNotifier {
  final token;

  CartProvider(this.token);

  int _total = 0;
  List<CartItemModel> _items = [];

  List<CartItemModel> get items {
    return [..._items];
  }

  int get total {
    _total = 0;
    for (var cart in _items) {
      _total += cart.price * cart.quantity;
    }
    return _total;
  }

  void addToCart(int id, String title, int price, int quantity) {
    _items.add(CartItemModel(
      productId: id,
      title: title,
      price: price,
      quantity: quantity,
    ));
    notifyListeners();
  }

  List<dynamic> get _getEachOrder {
    List<dynamic> tempList = [];
    _items.forEach((order) {
      int id = order.productId;
      int quantity = order.quantity;
      Map<String, int> tempMap = {'drug_id': id, 'quantity': quantity};
      tempList.add(tempMap);
    });
    return tempList;
  }

  Future<void> placeOrder() async {
    final url = Uri.parse('http://$host/api/order/create?lang_code=en');

    final response = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        <String, dynamic>{
          'orders': _getEachOrder,
        },
      ),
    );
    final data = json.decode(response.body);
    if (data['Status'] == 'Success'){
      _items = [];
      _total = 0;
      notifyListeners();
    }
  }

  void removeSingleItem(int id) {
    _items.removeWhere((cartItem) => cartItem.productId == id);
    notifyListeners();
  }

  void clearCart() {}
}
