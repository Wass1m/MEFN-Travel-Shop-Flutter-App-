import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler extends ChangeNotifier {
  String baseurl = 'http://192.168.1.109:5000';
  String errorMessage;
  bool loading = false;
  bool validate = false;
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<dynamic> get(String url) async {
    url = formater(url);
    String token = await storage.read(key: "token");

    var response = await http.get(
      url,
      headers: {"x-auth-token": "$token"},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }

    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);

    var response = await http.post(url,
        headers: {'Content-type': 'application/json'}, body: json.encode(body));

    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isLoading() {
    return loading;
  }

  void setValid(value) {
    validate = value;
    notifyListeners();
  }
}
