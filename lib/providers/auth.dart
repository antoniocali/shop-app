import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _auth(String email, String password, String urlType) async {
    final String _url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlType?key=AIzaSyC-3WtUMETzSgMnnxUABf-5_oTqViHJhdE';
    try {
      final response = await http.post(
        _url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );

      final body = json.decode(response.body);
      if (body['error'] != null) {
        throw http.ClientException(body['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _auth(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _auth(email, password, "signInWithPassword");
  }
}
