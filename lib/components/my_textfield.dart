import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hinttext;
  final bool obscuretext;
  final TextEditingController controller;
  const MyTextfield(
    {
    super.key,
    required this.hinttext,
    required this.obscuretext,
    required this.controller,
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        hintText: hinttext,
      ),
      obscureText: obscuretext,
    );
  }
}
