import 'dart:convert';
import '../main.dart';

import '../providers/drug_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrugsProvider with ChangeNotifier {
  final String token;

  DrugsProvider(this.token);

  late Drug _drugInfo = Drug(
    id: 0,
    tradeName: '',
    scientificName: '',
    company: '',
    tagId: 0,
    dose: 0,
    doseUnit: '',
    price: 0,
    quantity: 0,
    expiryDate: '',
    imageUrl: 'null',
  );

  List<Drug> _favoriteItems = [];

  Drug get drugInfo {
    return _drugInfo;
  }

  List<Drug> get favoriteItems {
    return [..._favoriteItems];
  }

  Future<void> fetchFavorites() async {
    final url = Uri.http(host, '/api/favorite/get', {'lang_code': 'en'});

    final response = await http.get(url, headers: {
      // 'ngrok-skip-browser-warning': '1',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    final data = json.decode(response.body);
    final drugs = data['Data'] as List<dynamic>;
    final List<Drug> temp = [];
    for (var drug in drugs) {
      temp.add(
        Drug(
          id: drug['id'],
          tradeName: drug['trade_name'],
          scientificName: drug['scientific_name'],
          company: drug['company'],
          tagId: drug['tag_id'],
          dose: drug['dose'],
          doseUnit: drug['dose_unit'],
          price: drug['price'],
          quantity: drug['quantity'],
          expiryDate: drug['expiry_date'],
          imageUrl: drug['img_url'].toString(),
          isFavorite: true,
        ),
      );
      _favoriteItems = temp;
    }
  }

  Future<void> addToFavorites(int id) async {
    final url = Uri.http(host, '/api/favorite/add/$id', {'lang_code': 'en'});

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final data = json.decode(response.body);
    final responseData = data['Status'];
    if (responseData == 'Success') {
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(int id) async {
    final url = Uri.http(host, '/api/favorite/delete/$id', {'lang_code': 'en'});

    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final data = json.decode(response.body);
    final responseData = data['Status'];
    if (responseData == 'Success') {
      _favoriteItems.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  Future<void> getDrugInfo(int id) async {
    final url = Uri.parse('http://$host/api/drug/get/$id?lang_code=en');

    final response = await http.get(
      url,
      headers: {
        // 'ngrok-skip-browser-warning': '1',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    final data = json.decode(response.body);
    final responseData = data['Data'];
    _drugInfo = Drug(
      id: responseData['id'],
      tradeName: responseData['trade_name'],
      scientificName: responseData['scientific_name'],
      company: responseData['company'],
      tagId: responseData['tag_id'],
      dose: responseData['dose'],
      doseUnit: responseData['dose_unit'],
      price: responseData['price'],
      quantity: responseData['quantity'],
      expiryDate: responseData['expiry_date'],
      imageUrl: responseData['img_url'].toString(),
      description: responseData['description'],
    );
  }
}
