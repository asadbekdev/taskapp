import 'dart:io';

import 'package:exam/constants.dart';
import 'package:exam/models/db_helper.dart';
import 'package:exam/models/user.dart';
import 'package:exam/screens/editprofile/edit_profile.dart';
import 'package:exam/screens/onboarding/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool darkModeSwitch = false;
  bool notificationSwitch = false;

  // img picker variables
  File? _image;
  final picker = ImagePicker();
  var pickedFile;

  Future getImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // database variables
  DatabaseHelper databaseHelper = DatabaseHelper();
  static DatabaseHelper? dbAccounts;
  static List<Account>? accountList;

  @override
  void initState() {
    accountList = <Account>[];
    dbAccounts = DatabaseHelper();
    accountList!.clear();
    dbAccounts!.fetchUser().then((allAccountsList) {
      setState(() {
        for (var readAccount in allAccountsList) {
          accountList!.add(Account.fromMap(readAccount));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kDefaultPadding / 2),
              Center(
                child: FutureBuilder(
                    future: dbAccounts!.fetchUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => getImage(),
                              child: _image == null
                                  ? Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: kPrimaryColor,
                                            width: 2.5,
                                          ),
                                          color: Colors.white),
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 30.0,
                                        color: kPrimaryColor,
                                      ),
                                    )
                                  : Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: kSecondaryColor, width: 2.5),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(height: kDefaultPadding / 2),
                            Text(
                              "${accountList![accountList!.length - 1].name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding / 6),
                            Text(
                              "${accountList![accountList!.length - 1].number}",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding / 4),
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Edit Profile",
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 17),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff5450D6),
                                fixedSize:
                                    Size(size.width * 0.37, size.height * 0.04),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return CircularProgressIndicator();
                    }),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff5450D6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.globe, color: Colors.white),
                              SizedBox(width: kDefaultPadding / 2),
                              Text(
                                "Language",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "English",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.moon, color: Colors.white),
                              SizedBox(width: kDefaultPadding / 2),
                              Text(
                                "Dark Mode",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              )
                            ],
                          ),
                          CupertinoSwitch(
                            value: darkModeSwitch,
                            onChanged: (value) {
                              setState(
                                () {
                                  darkModeSwitch == false
                                      ? darkModeSwitch = true
                                      : darkModeSwitch = false;
                                },
                              );
                            },
                            trackColor: Colors.white,
                            activeColor: kPrimaryColor,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ImageIcon(
                                AssetImage("assets/icons/Notification.png"),
                                color: Colors.white,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Text(
                                "Notifications",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              )
                            ],
                          ),
                          CupertinoSwitch(
                            value: notificationSwitch,
                            onChanged: (value) {
                              setState(() {
                                notificationSwitch == false
                                    ? notificationSwitch = true
                                    : notificationSwitch = false;
                              });
                            },
                            trackColor: Colors.white,
                            activeColor: kPrimaryColor,
                          )
                        ],
                      ),
                    ),
                    // SUPPORT BUTTON
                    ElevatedButton(
                      onPressed: () {
                        launch("https://t.me/asadbekdev");
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ImageIcon(
                                  AssetImage("assets/icons/send.png"),
                                  color: Colors.white,
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  "Support",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        CircularProgressIndicator();
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Onboarding(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding,
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                ImageIcon(
                                  AssetImage("assets/icons/signout.png"),
                                  color: Colors.white,
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  "Sign Out",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
