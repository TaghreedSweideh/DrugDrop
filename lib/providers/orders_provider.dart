import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/order_item_model.dart';
import '../models/cart_item_model.dart';

class OrdersProvider extends ChangeNotifier {
  final String token;

  OrdersProvider(this.token);

  List<OrderItemModel> _orders = [];

  List<OrderItemModel> get orders {
    return [..._orders.reversed];
  }

  Future<void> fetchDoneOrders() async {
    final url = Uri.parse('http://$host/api/order/get/done');

    final response = await http.get(
      url,
      headers: {
        // 'ngrok-skip-browser-warning': '1',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    final responseData = data['Data'] as List<dynamic>;
    List<OrderItemModel> temp = [];
    for (var order in responseData) {
        temp.add(
          OrderItemModel(
            id: order['id'],
            total: order['total_price'],
            status: order['status'],
            isPaid: order['is_paid'] == 0 ? false : true,
            products: [],
            dateTime: order['created_at'],
          ),
        );
      }
    _orders = temp;
  }

  Future<void> fetchUnDoneOrders() async {
    final url = Uri.parse('http://$host/api/order/get/undone');

    final response = await http.get(
      url,
      headers: {
        // 'ngrok-skip-browser-warning': '1',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    final responseData = data['Data'] as List<dynamic>;
    List<OrderItemModel> temp = [];
    for (var order in responseData) {
        temp.add(
          OrderItemModel(
            id: order['id'],
            total: order['total_price'],
            status: order['status'],
            isPaid: order['is_paid'] == 0 ? false : true,
            products: [],
            dateTime: order['created_at'],
          ),
        );
      }
    _orders = temp;
  }

  Future<void> fetchOrderDrugs(int id) async {
    final url = Uri.parse('http://$host/api/order/get/$id');

    final response = await http.get(
      url,
      headers: {
        // 'ngrok-skip-browser-warning': '1',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    final responseData = json.decode(data['Data']['invoice']) as List<dynamic>;
    final List<CartItemModel> tempDrugs = [];
    for (var drug in responseData) {
      tempDrugs.add(
        CartItemModel(
          productId: -1,
          title: drug['Drug Name'],
          quantity: drug['Quantity'],
          price: drug['Drug Price'],
        ),
      );
    }
    int index = _orders.indexWhere((order) => order.id == id);
    _orders[index].products = tempDrugs;
  }
}
