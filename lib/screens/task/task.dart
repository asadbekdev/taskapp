import 'package:exam/constants.dart';
import 'package:exam/screens/task/components/body.dart';
import 'package:exam/screens/tasks/components/avatar.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: kDefaultPadding),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: ImageIcon(
              AssetImage("assets/icons/arrow_left.png"),
              color: kTextColor,
              size: 45,
            ),
            color: kTextColor,
            padding: EdgeInsets.zero,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: kDefaultPadding),
            child: Avatar(img: "assets/images/myPic.jpg", radius: 15),
          ),
        ],
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      body: Body(),
    );
  }
}
