import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _experyDate;
  String? _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.https("//identitytoolkit.googleapis.com",
        "/v1/accounts:signInWithCustomToken?key=AIzaSyDDRUgqEgu47XPkiUs11c0tJc_gIRV2fz0");
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          "returnSecureToken": true,
        }));
    print(json.decode(response.body));
  }
}
