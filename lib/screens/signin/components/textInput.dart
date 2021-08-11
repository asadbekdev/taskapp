import 'package:flutter/material.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  TextInput({
    Key? key,
    this.prefixIcon,
    this.keyboardType,
    this.hintText,
    this.validator,
    this.onChanged,
    this.controller
  }) : super(key: key);
  var prefixIcon, keyboardType, hintText, onChanged,controller;
  var validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusColor: kPrimaryColor,
        hoverColor: kPrimaryColor,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(kDefaultPadding * 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(kDefaultPadding * 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(kDefaultPadding * 2),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
              left: kDefaultPadding * 1.3, right: kDefaultPadding / 2),
          child: prefixIcon,
        ),
      ),
      style: TextStyle(color: kPrimaryColor),
      cursorColor: kPrimaryColor,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
