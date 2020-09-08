import 'dart:convert';
import 'dart:developer';
import 'package:Wassines/Model/Product.dart';
import 'package:Wassines/Model/User.dart';
import 'package:Wassines/NetworkHandler/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products;
  Product product;
  String errorMessage;
  bool loading = false;
  Logger log;

  // NetworkHandler networkHandler = NetworkHandler();

  // void getUser() async {
  //   var response = await networkHandler.get('/api/auth');
  //   log.i(response);
  //   setUser(User.fromJson(response));
  // }

  void setProduct(value) {
    product = value;
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setProducts(value) {
    products = value;
    notifyListeners();
  }

  List<Product> getProducts() {
    return products;
  }

  Product getProduct() {
    return product;
  }

  bool isProductLoading() {
    return loading;
  }

  String productErrorMessage() {
    return errorMessage;
  }
}
