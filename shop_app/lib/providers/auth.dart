import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> logout() async {
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    _token = null;
    _expiryDate = null;
    _userId = null;
    notifyListeners();
    await SharedPreferences.getInstance()
      ..clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${dotenv.env['FIREBASE_KEY']}");
    final response = await http.post(url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    _token = json.decode(response.body)["idToken"];
    _userId = json.decode(response.body)["localId"];
    _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(json.decode(response.body)["expiresIn"])));
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      "token": _token,
      "userId": _userId,
      "expiryDate": _expiryDate.toIso8601String()
    });
    prefs.setString("userData", userData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final userData =
        json.decode(prefs.getString("UserData")) as Map<String, Object>;
    final expiryDate = DateTime.parse(userData["expiryDate"]);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = userData["token"];
    _expiryDate = expiryDate;
    _userId = userData["userId"];
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logIn(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${dotenv.env['FIREBASE_KEY']}");
    final response = await http.post(url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    _token = json.decode(response.body)["idToken"];
    _userId = json.decode(response.body)["localId"];
    _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(json.decode(response.body)["expiresIn"])));
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
  }
}
