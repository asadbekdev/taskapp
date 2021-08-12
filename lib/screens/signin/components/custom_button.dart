import 'package:exam/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.size,
  }) : super(key: key);

  final Size size;
  var text,onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text.toString()),
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        fixedSize: Size(size.width * 0.5, size.height * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding * 2),
        ),
      ),
    );
  }
}
