import 'package:Wassines/Model/CartProvider.dart';
import 'package:Wassines/Pages/PaymentPage.dart';
import 'package:Wassines/styleGuide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Text(
                'Your Cart',
                style: kheadlineStyle,
              ),
              Text(
                '${Provider.of<CartProvider>(context).itemsNumber()} Items',
                style: kcategoryStyle.copyWith().apply(color: Colors.black),
              ),
              Container(
                child: ProductList(),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ksecondaryColor,
                      ),
                      child: Align(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_shipping,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              'FREE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black54))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total:'),
                            Text(
                                '${Provider.of<CartProvider>(context).totalPrice()} \$',
                                style: kheadlineStyle),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: ksecondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 50.0,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage()));
                    },
                    child: Text('Checkout', style: kcategoryStyle),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final product = cart.getProduct(index);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'http://192.168.1.110:5000/${product.images[0]}',
                          width: 90,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(product.title, style: kcategoryStyle),
                                Text('${product.price}\$',
                                    style: kcategoryStyle)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .removeProduct(product.title);
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: kprimaryColor,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: cart.itemsNumber(),
      ),
    );
  }
}
