import 'dart:convert';
import 'dart:developer';
import 'package:Wassines/Model/User.dart';
import 'package:Wassines/NetworkHandler/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserProvider extends ChangeNotifier {
  User user;
  String errorMessage;
  bool loading = false;
  Logger log;

  // NetworkHandler networkHandler = NetworkHandler();

  // void getUser() async {
  //   var response = await networkHandler.get('/api/auth');
  //   log.i(response);
  //   setUser(User.fromJson(response));
  // }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  User getUser() {
    return user;
  }

  bool isUserLoading() {
    return loading;
  }

  String userErrorMessage() {
    return errorMessage;
  }
}
