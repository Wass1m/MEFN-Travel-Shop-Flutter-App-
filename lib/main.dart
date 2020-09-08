import 'package:Wassines/Model/CartProvider.dart';
import 'package:Wassines/Model/ProductProvider.dart';
import 'package:Wassines/Model/UserProvider.dart';
import 'package:Wassines/NetworkHandler/NetworkHandler.dart';
import 'package:Wassines/Screens/home-screen.dart';
import 'package:Wassines/Screens/loadingScreen.dart';
import 'package:Wassines/Screens/login-screen.dart';
import 'package:Wassines/Screens/welcome-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = FlutterSecureStorage();
  Widget page = LoadingPage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buybuy();
    checkLogin();
  }

  void buybuy() async {
    await storage.delete(key: 'token');
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    print(token);
    if (token != null) {
      setState(() {
        page = WelcomePage();
      });
    } else {
      setState(() {
        page = HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkHandler>(
          create: (context) => NetworkHandler(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        home: page,
      ),
    );
  }
}
