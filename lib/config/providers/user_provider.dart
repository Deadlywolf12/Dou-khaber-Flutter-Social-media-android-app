import 'package:cinepopapp/utils/auth_functions.dart';
import 'package:flutter/material.dart';
import 'package:cinepopapp/config/models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthFunctions _authFunctions = AuthFunctions();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authFunctions.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
