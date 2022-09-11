import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/helpers/api_key.dart';
import 'package:shop_app/models/http_exeptions.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _auth(String email, String pas, String method) async {
    final url = Uri.https('identitytoolkit.googleapis.com',
        '/v1/accounts:$method', {'key': API_KEY});
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': pas,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpExeptions(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String pas) async {
    return _auth(email, pas, 'signUp');
  }

  Future<void> sigin(String email, String pas) async {
    return _auth(email, pas, 'signInWithPassword');
  }
}
