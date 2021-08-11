import 'package:exam/constants.dart';
import 'package:exam/screens/editprofile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close,color: kTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Edit Profile",style: TextStyle(color: kTextColor),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
