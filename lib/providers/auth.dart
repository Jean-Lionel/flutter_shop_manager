import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _experyDate;
  String? _userId;

  Future<void> _authenticatedMethod(
      String email, String password, String urlSetting) async {
    print("EMail ${email} password ${password}");
    final url = Uri.https(
        "identitytoolkit.googleapis.com",
        "/v1/accounts:$urlSetting",
        {'key': 'AIzaSyDDRUgqEgu47XPkiUs11c0tJc_gIRV2fz0'});
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': false
        }));

    print("Response : ${json.encode(response.body)}");
  }

  Future<void> login(String email, String password) async {
    return _authenticatedMethod(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) async {
    return _authenticatedMethod(email, password, 'signUp');
  }
}
