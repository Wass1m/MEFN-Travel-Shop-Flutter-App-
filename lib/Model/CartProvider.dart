import 'dart:convert';

import 'package:Wassines/Model/Cart.dart';
import 'package:Wassines/Model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _products = List<Product>();

  bool loading = false;

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  saveList(String key, list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  readList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  void loadSharedPrefs() async {
    List<String> productsItem = await readList("cart");
    List<Product> productsTemp = productsItem
        .map((product) => Product.fromJson(json.decode(product)))
        .toList();

    setProducts(productsTemp);
    print('yaw');
    print(_products);
    print(itemsNumber());
    print('yaw');
  }

  void addCartItem(Product item) {
    print(_products);
    // List<Product> productsList = List<Product>();
    // print(item.title);
    // print(productsList);
    _products.add(item);
    print(_products);
    List<String> listProducts =
        _products.map((elm) => json.encode(elm)).toList();
    print(listProducts);
    saveList('cart', listProducts);
    notifyListeners();
  }

  Product getProduct(id) {
    return _products[id];
  }

  void reset() {
    _products = [];
    List<String> empty = List<String>();
    saveList('cart', empty);
    notifyListeners();
  }

  int itemsNumber() {
    return _products.length;
  }

  int totalPrice() {
    return _products.fold(
        0, (previousValue, element) => previousValue + element.price);
  }

  void removeProduct(id) {
    setProducts(_products.where((product) => product.title != id).toList());
  }

  void setProducts(value) {
    _products = value;
    notifyListeners();
  }
}
