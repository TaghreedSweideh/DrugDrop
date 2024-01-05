import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';
  int _userId = 0;

  String get token {
    if (_token.isNotEmpty) {
      return _token;
    }
    return '';
  }

  int get userId {
    if (_userId != 0) {
      return _userId;
    }
    return -1;
  }

  bool get isAuth {
    return token != '';
  }

  Future<void> login(String phoneNumber, String password) async {
    final url = Uri.parse('http://$host/api/user/login');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'phone_number': '09$phoneNumber',
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData == null) {
        throw Exception();
      }
      if (responseData['Status'] == 'Failed') {
        throw Exception('Failed');
      }
      _token = responseData['Data']['token'];
      _userId = responseData['Data']['id'];
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(
      String name, String phoneNumber, String location, String password) async {
    final url = Uri.parse('http://$host/api/user/create');
    try {
      final response = await http.put(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'name': name,
          'phone_number': '09$phoneNumber',
          'location': location,
          'password': password,
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData == null) {
        throw Exception();
      }
      if (responseData['Status'] == 'Failed') {
        throw Exception(responseData['Error']);
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('http://$host/api/user/logout');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = json.decode(response.body);
    } catch (error) {
      rethrow;
    }
    _token = '';
    notifyListeners();
  }

  Future<void> codeVerification(String phoneNumber, String code) async {
    final url = Uri.parse('http://$host/api/user/recive_verification_code');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        'phone_number': phoneNumber,
        'pin_code': code,
      }
    );
    final data = json.decode(response.body);
    print(data);
  }

  Future<void> forgotPassword(String phoneNumber) async {
    final url = Uri.parse('http://$host/api/user/create');
  }
}
