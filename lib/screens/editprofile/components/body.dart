import 'package:exam/components/text_input.dart';
import 'package:exam/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var visibilityIcon = CupertinoIcons.eye;
  var obsecuretext = true;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: kDefaultPadding),
            CircleAvatar(),
            SizedBox(height: kDefaultPadding * 1.5),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextInput(
                      title: 'Full Name',
                      hintText: "Enter your full name",
                      initialValue: "Asadbek Noyibjonov",
                      maxLength: 20,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Enter at least 6 letters';
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    TextInput(
                      title: 'Your Number',
                      hintText: "Enter your number",
                      initialValue: '+998991975842',
                      maxLength: 13,
                      validator: (value) {
                        if (value.length < 13) {
                          return 'Enter the number correctly';
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    TextInput.password(
                      title: 'Your password',
                      hintText: 'Enter the password',
                      initialValue: "112233",
                      obscureText: obsecuretext,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (obsecuretext == true) {
                              obsecuretext = false;
                              visibilityIcon = CupertinoIcons.eye_slash;
                            } else {
                              obsecuretext = true;
                              visibilityIcon = CupertinoIcons.eye;
                            }
                          });
                        },
                        icon: Icon(visibilityIcon),
                      ),
                      maxLength: 14,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Enter at least 6 letters';
                        }
                      },
                    ),
                    SizedBox(height: kDefaultPadding),
                    ElevatedButton(
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        fixedSize: Size(size.width * 0.3, size.height * 0.07),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
