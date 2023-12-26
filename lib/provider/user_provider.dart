import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late User _user;
  bool _isLoggedIn = false;

  User get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  UserProvider() {
    loadUserData();
  }

  // Load user data from local storage
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = User.fromJson({
      'userId': prefs.getString('userId') ?? '',
      'name': prefs.getString('name') ?? '',
      'phone': prefs.getString('phone') ?? '',
      'email': prefs.getString('email') ?? '',
    });
    if (_user.name.isNotEmpty) {
      _isLoggedIn = true;
    }
    notifyListeners();
  }

  // Save user data to local storage
  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', _user.userId);
    prefs.setString('name', _user.name);
    prefs.setString('phone', _user.phone);
    prefs.setString('email', _user.email);
  }

  // Update user data
  void updateUserData({
    required String newUserId,
    required String newName,
    required String newPhone,
    required String newEmail,
  }) {
    _user = User(
      userId: newUserId,
      name: newName,
      phone: newPhone,
      email: newEmail,
    );
    if (_user.name.isNotEmpty) {
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    saveUserData();
    notifyListeners();
  }
}
