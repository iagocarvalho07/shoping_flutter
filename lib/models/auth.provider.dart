import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shoping_flutter/execptions/auth_exception.dart';

class AuthProvider with ChangeNotifier {
  static const _ApiKeyWeb = 'AIzaSyAOICR0yxTraeQRfCIpQPyrikFSs99Zh1A';

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=$_ApiKeyWeb';
    final response = await post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final body = jsonDecode(response.body);
    if(body['error'] != null){
      throw AuthException(body['error']['message']);
    };

  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
