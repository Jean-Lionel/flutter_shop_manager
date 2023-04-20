import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _experyDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _experyDate != null &&
        _experyDate!.isAfter(DateTime.now())) {
      return _token;
    }
  }

  Future<void> _authenticatedMethod(
      String email, String password, String urlSetting) async {
    print("EMail ${email} password ${password}");
    final url = Uri.https(
        "identitytoolkit.googleapis.com",
        "/v1/accounts:$urlSetting",
        {'key': 'AIzaSyDDRUgqEgu47XPkiUs11c0tJc_gIRV2fz0'});

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': false
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _experyDate = DateTime.now().add(
        Duration(seconds: (60 * 60 * 24 * 60)),
      );
      // print(responseData["localId"]);
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticatedMethod(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) async {
    return _authenticatedMethod(email, password, 'signUp');
  }
}
