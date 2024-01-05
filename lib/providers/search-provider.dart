import '/providers/drug_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';
import '../models/category.dart';

class SearchProvider with ChangeNotifier {
  final String token;

  SearchProvider(this.token);

  List<Categories> _searchedCategories = [];
  List<Drug> _searchedDrugs = [];

  List<Categories> get searchedCategories {
    return [..._searchedCategories];
  }

  Categories findCatById(int id) {
    return _searchedCategories.firstWhere((cat) => cat.id == id);
  }

  List<Drug> get searchedDrugs {
    return [..._searchedDrugs];
  }

  Drug findDrugById(int id) {
    return _searchedDrugs.firstWhere((drug) => drug.id == id);
  }

  Future<void> getResult(String type, String value, String cat) async {
    print('getting results');
    var url;
    print('$type and $value');
    if (type == 'Medicine') {
      url = Uri.http(host, '/api/search/drug',
          {'lang_code': 'en', 'search': value, 'category': cat});
    } else if (type == 'Category') {
      url = Uri.http(host, '/api/search/category', {'search': value});
    }

    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer $token'
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Categories> loadedCategories = [];
      List<Drug> loadedDrugs = [];
      if (extractedData == Null) {
        return;
      }
      print(extractedData);
      if (type == 'Category') {
        extractedData['Data'].forEach((index) {
          loadedCategories.add(Categories(
            id: index['id'],
            en_name: index['en_name'],
            ar_name: index['ar_name'],
          ));
        });
        _searchedCategories = loadedCategories;
      } else if (type == 'Medicine') {
        extractedData['Data'].forEach((drug) {
          loadedDrugs.add(
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
                expiryDate: drug['expiry_date'].toString(),
                imageUrl: drug['img_url'] ?? 'null'),
          );
        });
        _searchedDrugs = loadedDrugs;
      } else {
        print('There is nothing to be fetched');
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
      //throw (error);
    }
  }
}
