import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth => _token != null;

  String get token => _expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null ? _token : null;

  String get userId => _userId;

  Future<void> _authenticate(String email, String password) async {
    final url = 'https://temp545485.com.br';

    try {
      final resp = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final data = json.decode(resp.body);
      if (data['error'] != null) throw HttpException(data['error']['message']);

      _token = data['idToken'];
      _userId = data['localId'];
      _expiryDate = DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));

      notifyListeners();

    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async => _authenticate(email, password);
}
