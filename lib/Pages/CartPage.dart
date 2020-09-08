import 'package:Wassines/Model/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            Provider.of<CartProvider>(context, listen: false).reset();
          },
          child: Text('Cart')),
    );
  }
}
