import 'package:Wassines/Model/CartProvider.dart';
import 'package:Wassines/Pages/CartPage.dart';
import 'package:Wassines/Pages/ExplorePage.dart';
import 'package:Wassines/Pages/Profile/EditProfile.dart';
import 'package:Wassines/styleGuide.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndexPage = 0;
  final List<Widget> widgets = [ExplorePage(), CartPage(), CartPage()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).loadSharedPrefs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: ksecondaryColor,
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage:
                                AssetImage('assets/images/wassim.jpg'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            },
                            child: CircleAvatar(
                              backgroundColor: kprimaryColor,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text('Wassim'),
                ],
              ),
            )
          ],
        ),
      ),
      // backgroundColor: Color(0xff0ceba0),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Color(0xff0ceba0),
        items: [
          Icon(Icons.home, size: 30),
          Stack(
            children: [
              Icon(Icons.shopping_cart, size: 30),
              Positioned(
                right: 0,
                child: Provider.of<CartProvider>(context).itemsNumber() == 0
                    ? Container(width: 0.0, height: 0.0)
                    : CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 8,
                        child: Text(
                          '${Provider.of<CartProvider>(context).itemsNumber()}',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
              )
            ],
          ),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            currentIndexPage = index;
          });
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: new Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
              child: CircleAvatar(
                radius: 27,
                backgroundColor: ksecondaryColor,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/wassim.jpg'),
                  radius: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      body: widgets[currentIndexPage],
    );
  }
}
