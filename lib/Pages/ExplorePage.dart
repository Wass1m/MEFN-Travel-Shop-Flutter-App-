import 'dart:convert';

import 'package:Wassines/Model/Product.dart';
import 'package:Wassines/Model/ProductProvider.dart';
import 'package:Wassines/Model/UserProvider.dart';
import 'package:Wassines/NetworkHandler/NetworkHandler.dart';
import 'package:Wassines/Pages/ProductPage.dart';
import 'package:Wassines/styleGuide.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({
    Key key,
  }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  NetworkHandler networkHandler = NetworkHandler();
  Logger log;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchUser();
    });
  }

  void fetchUser() async {
    Provider.of<ProductProvider>(context, listen: false).setLoading(true);
    var response = await networkHandler.post('/api/product/', {});

    Iterable decode = json.decode(response.body);
    print(decode);

    List<Product> products;

    // decode.map((product) => products.add(Product.fromJson(product)));
    print('try');
    // decode.map((product) => print(product.title));
    products = decode.map((product) => Product.fromJson(product)).toList();

    print('try');
    print(products);

    Provider.of<ProductProvider>(context, listen: false).setProducts(products);
    // Provider.of<ProductProvider>(context, listen: false)
    //     .setProducts(Product.fromJson(response));
    // Provider.of<ProductProvider>(context, listen: false).setLoading(false);
    Provider.of<ProductProvider>(context, listen: false).setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Explore', style: kheadlineStyle),
                // GestureDetector(
                //   onTap: () {
                //     _scaffoldKey.currentState.openDrawer();
                //   },
                //   child: CircleAvatar(
                //     radius: 27,
                //     backgroundColor: ksecondaryColor,
                //     child: CircleAvatar(
                //       backgroundImage: AssetImage('assets/images/wassim.jpg'),
                //       radius: 25,
                //     ),
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage()));
                    },
                    child: Text(
                      'Sights',
                      style: kcategoryStyle,
                    ),
                  ),
                  Text('Tours', style: kcategoryStyleAxctive),
                  Text('Adventures', style: kcategoryStyle),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('23 sights', style: kNumberCategory),
            Provider.of<ProductProvider>(context).isProductLoading()
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kprimaryColor,
                        strokeWidth: 4,
                      ),
                    ),
                  )
                : Container(
                    height: 280,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Provider.of<ProductProvider>(context)
                            .getProducts()
                            .length,
                        itemBuilder: (context, index) => ProductItem(
                              Provider.of<ProductProvider>(context)
                                  .getProducts()[index],
                            )),
                  ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) => PopularItem()),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  Product product;
  ProductItem(this.product);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductPage(product: widget.product)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlueAccent,
            image: DecorationImage(
                image: NetworkImage(
                  'http://192.168.1.110:5000/${widget.product.images[0]}',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken)),
          ),
          height: 280,
          width: 200,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                right: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(
                    Icons.favorite,
                    color: ksecondaryColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  children: [
                    Row(
                      children: [Text('⭐ ⭐ ⭐ ⭐ ⭐'), Text('4.6')],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.product == null
                              ? 'name'
                              : widget.product.title,
                          style: kproductName,
                        ),
                        // Text('Excursion', style: kproductName),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PopularItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5, offset: Offset(0, 0.6), color: Colors.black)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/baha2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'European tour',
                      style: kcategoryStyle,
                    ),
                    Text(
                      '14 april -  25 april',
                      style: kNumberCategory,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '300\$',
                    style: kcategoryStyle,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
