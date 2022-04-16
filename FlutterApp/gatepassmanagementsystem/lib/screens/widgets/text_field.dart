import 'package:flutter/material.dart';
class WidTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;
  WidTextField({required this.hintText,required this.icon,required  this.obscureText,required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          prefixIcon: Icon(icon,color: Colors.grey,),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
              borderSide:  BorderSide(color: Colors.grey)
          )
      ),
    );
  }
}