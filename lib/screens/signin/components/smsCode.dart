import 'package:exam/screens/main/main_page.dart';
import 'package:exam/screens/signin/components/custom_button.dart';
import 'package:exam/screens/signin/components/textInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;

// ignore: must_be_immutable
class SmsCode extends StatefulWidget {
  SmsCode({Key? key, this.phoneNumber}) : super(key: key);
  TextEditingController? phoneNumber;

  @override
  _SmsCodeState createState() => _SmsCodeState();
}

class _SmsCodeState extends State<SmsCode> {
  TextEditingController otpCode = TextEditingController();

  bool isLoading = false;

  String? verificationId;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: kTextColor,
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   shadowColor: Colors.transparent,
      //   elevation: 0,
      // ),
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Verify Phone Number",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    "${widget.phoneNumber!.text}",
                    style: TextStyle(
                      color: kSecondaryColor,
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  TextInput(
                    controller: otpCode,
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                    ),
                    keyboardType: TextInputType.number,
                    hintText: "SMS Code",
                  ),
                  SizedBox(height: kDefaultPadding * 2),
                  CustomButton(
                    size: size,
                    text: "Sign In",
                    onPressed: verifyPhone,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  verifyPhone() async {
    await auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber!.text,
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = otpCode.text;

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        await auth.signInWithCredential(credential);
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      },
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Text("Check sms code and try again !"),
          ),
        );
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }
}
