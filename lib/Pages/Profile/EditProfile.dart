import 'dart:io';

import 'package:Wassines/Model/User.dart';
import 'package:Wassines/Model/UserProvider.dart';
import 'package:Wassines/NetworkHandler/NetworkHandler.dart';
import 'package:Wassines/styleGuide.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
    Provider.of<UserProvider>(context, listen: false).setLoading(true);
    var response = await networkHandler.get('/api/auth');

    Provider.of<UserProvider>(context, listen: false)
        .setUser(User.fromJson(response));
    Provider.of<UserProvider>(context, listen: false).setLoading(false);
  }

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
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
                child: Provider.of<UserProvider>(context).isUserLoading()
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: kprimaryColor,
                            strokeWidth: 4,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundColor: kprimaryColor,
                                child: CircleAvatar(
                                  radius: 78,
                                  backgroundImage: _imageFile == null
                                      ? AssetImage('assets/images/wassim.jpg')
                                      : FileImage(File(_imageFile.path)),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) {
                                        var container =
                                            buildBottomSheet(context);
                                        return container;
                                      }),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: kprimaryColor,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                              Provider.of<UserProvider>(context).getUser() ==
                                      null
                                  ? 'lOADING'
                                  : Provider.of<UserProvider>(context)
                                      .getUser()
                                      .name,
                              style: kheadlineStyle)
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildBottomSheet(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Choose profile photo', style: kheadlineStyle),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }
}
