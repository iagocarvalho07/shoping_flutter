import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  Future<void> SingUp() async {
    const AuthUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=[API_KEY]';
  }
}
