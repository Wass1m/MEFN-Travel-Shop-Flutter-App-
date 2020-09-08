import 'package:Wassines/Model/CartProvider.dart';
import 'package:Wassines/Model/Product.dart';
import 'package:Wassines/styleGuide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  ProductPage({this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'http://192.168.1.109:5000/${product.images[0]}',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 30),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .loadSharedPrefs();
                        },
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [Text('⭐ ⭐ ⭐ ⭐ ⭐'), Text('4.6')],
                      ),
                      Text(
                        product.title,
                        style: kheadlineStyleWhite,
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      color: Colors.transparent,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Bahamas, South America'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Description'),
                              Text(
                                'Total : 400\$',
                                style: kproductName.copyWith().apply(
                                    color: Colors.black, fontFamily: 'Lato'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          print(product);
                          Provider.of<CartProvider>(context, listen: false)
                              .addCartItem(product);
                        },
                        child: Container(
                          height: 70,
                          width: 150,
                          decoration: BoxDecoration(
                            color: ksecondaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Align(
                            child: Text(
                              'Order',
                              style: kproductName,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
