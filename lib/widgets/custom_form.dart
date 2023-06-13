import 'package:flutter/material.dart';
import 'package:siskom_tv_dosen/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputAction action;
  final bool obscureText;
  final TextInputType keyboardType;
  TextEditingController controller;
  CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    required this.controller,
    this.action = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        keyboardType: keyboardType,
        textInputAction: action,
        controller: controller,
        obscureText: obscureText,
        cursorColor: Color.fromARGB(255, 187, 142, 7),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          labelText: labelText,
          errorStyle: blackTextStyle.copyWith(
              fontSize: 12, color: blackC.withOpacity(0.6), height: 1),
          labelStyle: blueTextStyle.copyWith(
              fontSize: 13, color: Color.fromARGB(255, 187, 142, 7)),
          hintText: hintText,
          hintStyle: blackTextStyle.copyWith(
            fontSize: 13,
            color: blackC.withOpacity(0.87),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              4,
            ),
            borderSide: BorderSide(color: Color.fromARGB(255, 187, 142, 7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              4,
            ),
            borderSide: BorderSide(color: Color.fromARGB(255, 187, 142, 7)),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 187, 142, 7),
              ),
              borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
