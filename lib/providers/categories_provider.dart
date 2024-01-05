import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/category.dart';

class CategoriesProvider with ChangeNotifier {
  final String token;

  CategoriesProvider(this.token);

  List<Categories> _categories = [];

  List<Categories> get categories {
    return [..._categories];
  }

  Categories findById(int id) {
    return _categories.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchCategories() async {
    final url = Uri.http(host, '/api/category/get');
    try {
      final response = await http.get(url, headers: {
        // 'ngrok-skip-browser-warning': '1',
        'Accept': 'application/json',
        'Authorization':
            'Bearer $token',
      },);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Categories> loadedCategories = [];
      if (extractedData == Null) {
        return;
      }
      extractedData['Data'].forEach((index) {
        loadedCategories.add(Categories(
          id: index['id'],
          en_name: index['en_name'],
          ar_name: index['ar_name'],
        ));
      });
      _categories = loadedCategories;
      notifyListeners();
    } catch (error) {
      //throw (error);
    }
  }
}
