import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Avatar extends StatelessWidget {
  Avatar({
    Key? key,
    required this.img,
    required this.radius,
  }) : super(key: key);
  var img,radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(3),
      child: CircleAvatar(
        radius: radius.toDouble(),
        backgroundImage: AssetImage("$img"),
      ),
    );
  }
}
