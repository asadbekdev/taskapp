import 'package:exam/screens/signin/components/custom_button.dart';
import 'package:exam/screens/signin/components/smsCode.dart';
import 'package:exam/screens/signin/components/textInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController phoneNumber = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? username;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: kDefaultPadding * 2),
            child: Image.asset(
              "assets/images/signIn_Svg.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: kDefaultPadding),
          Text(
            "Welcome back!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Text(
            "Log in to your existant account of Task App",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding * 1.7,
              ),
              child: Column(
                children: [
                  TextInput(
                    prefixIcon: Icon(
                      CupertinoIcons.person,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Username",
                    onChanged: (u) {
                      username = u;
                    },
                    validator: (value) {
                      if (value.length < 6) {
                        return "Enter the 6 letters at least";
                      }
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  TextInput(
                    controller: phoneNumber,
                    prefixIcon: Icon(
                      CupertinoIcons.phone,
                    ),
                    keyboardType: TextInputType.phone,
                    hintText: "Phone Number",
                  ),
                  SizedBox(height: kDefaultPadding),
                  CustomButton(
                    size: size,
                    text: "Send",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SmsCode(
                            phoneNumber: phoneNumber,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: kDefaultPadding * 1.5),
        ],
      ),
    );
  }
}
