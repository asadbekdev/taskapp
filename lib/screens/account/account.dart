import 'package:exam/constants.dart';
import 'package:exam/screens/account/components/body.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}