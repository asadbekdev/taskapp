import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: must_be_immutable
class TextInput extends StatefulWidget {
  TextInput({
    Key? key,
    required this.title,
    required this.hintText,
    required this.initialValue,
    required this.validator,
    required this.maxLength,
  }) : super(key: key);
  TextInput.password({
    Key? key,
    required this.title,
    required this.hintText,
    required this.initialValue,
    required this.obscureText,
    required this.suffixIcon,
    required validator,
    required this.maxLength
  }) : super(key: key);

  var hintText,
      title,
      initialValue,
      keyboardType,
      obscureText = false,
      suffixIcon,
      validator,
      maxLength = 20;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title.toString(),
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: kDefaultPadding / 2),
        TextFormField(
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffF5F5F5),
            hintText: widget.hintText.toString(),
            hintStyle: TextStyle(
              color: kSecondaryColor,
              fontSize: 13.0,
            ),
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding),
          ),
        ),
      ],
    );
  }
}
