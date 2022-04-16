import 'package:flutter/material.dart';
class WidTextFieldNIC extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  WidTextFieldNIC({required this.hintText,required  this.obscureText,required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
              borderSide:  BorderSide(color: Colors.grey)
          )
      ),
    );
  }
}