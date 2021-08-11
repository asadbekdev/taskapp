import 'package:flutter/material.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class TaskItem extends StatelessWidget {
  TaskItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.users,
    required this.time,
  }) : super(key: key);
  var title, subtitle, users, time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff5450D6),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          Text(
            "$subtitle",
            style: TextStyle(
              color: Color(0xff99A7e8),
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: kDefaultPadding / 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: users,
              ),
              Text(
                "$time",
                style: TextStyle(
                  color: Color(0xff99A7e8),
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}