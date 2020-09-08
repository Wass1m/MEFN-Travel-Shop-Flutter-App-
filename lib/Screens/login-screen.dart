import 'dart:convert';
import 'package:Wassines/Screens/welcome-page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'package:Wassines/NetworkHandler/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalKey2 = GlobalKey<FormState>();
  FlutterSecureStorage storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xff00a7ff),
                    Color(0xff0ceba0),
                  ],
                ),
              ),
              child: Form(
                key: _globalKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'LOGO',
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    buildEmailField(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    buildPasswordField(),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () async {
                            // Navigator.pop(context);
                            if (_globalKey2.currentState.validate()) {
                              // we will send data to rest server
                              // print("validated");
                              Map<String, String> data = {
                                "email": _emailController.text,
                                "password": _passwordController.text
                              };

                              Provider.of<NetworkHandler>(context,
                                      listen: false)
                                  .setLoading(true);

                              print(data);
                              var response =
                                  await networkHandler.post('/api/auth', data);

                              print(response.body);
                              print(response.statusCode);
                              if (response.statusCode == 400 ||
                                  response.statusCode == 401) {
                                Provider.of<NetworkHandler>(context,
                                        listen: false)
                                    .setLoading(false);
                                Provider.of<NetworkHandler>(context,
                                        listen: false)
                                    .setValid(false);
                                Provider.of<NetworkHandler>(context,
                                        listen: false)
                                    .setMessage('Invalid Credentials');
                              } else if (response.statusCode == 500) {
                                Provider.of<NetworkHandler>(context,
                                        listen: false)
                                    .setLoading(false);
                                Provider.of<NetworkHandler>(context,
                                        listen: false)
                                    .setValid(false);
                                Provider.of<NetworkHandler>(context,
                                        listen: false)
                                    .setMessage('SERVER PROBLEM');
                              } else if (response.statusCode == 200 ||
                                  response.statusCode == 201) {
                                Provider.of<NetworkHandler>(context,
                                        listen: false)
                                    .setLoading(false);
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                await storage.write(
                                    key: 'token', value: output['token']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomePage(),
                                  ),
                                );
                              }
                            }
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child:
                              Provider.of<NetworkHandler>(context).isLoading()
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.black,
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      'Login',
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: _passwordController,
        validator: (value) {
          if (value.isEmpty) return 'Password cannot be empty';
          if (value.length < 6) return 'Pasword is invalid';
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter your password.',
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }

  Padding buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onChanged: (value) {
          Provider.of<NetworkHandler>(context, listen: false).setMessage(null);
        },
        controller: _emailController,
        validator: (value) {
          if (value.isEmpty) return 'Email cannot be empty';
          if (!value.contains('@')) return 'Email is invalid';
          return null;
        },
        decoration: InputDecoration(
          errorText: Provider.of<NetworkHandler>(context).getMessage(),
          hintText: 'Enter your email',
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
