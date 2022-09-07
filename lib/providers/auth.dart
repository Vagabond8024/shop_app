import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exeptions.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> _auth(String email, String pas, String method) async {
    final url = Uri.https(
        'identitytoolkit.googleapis.com',
        '/v1/accounts:$method',
        {'key': 'AIzaSyDu4UhChVkSEUqxSa6AfQhZ3d9JSt7rp9A'});
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': pas,
            'returnSecureToken': true,
          }));
      print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpExeptions(responseData['error']['message']);
      }
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
