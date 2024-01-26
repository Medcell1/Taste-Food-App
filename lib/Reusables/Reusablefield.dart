import 'package:flutter/material.dart';

class ReusableField extends StatelessWidget {


  final dynamic text;
  final dynamic validator;
  final dynamic onSaved;
  final dynamic obscureText;
  final dynamic onTapped;
  final dynamic inputType;
  final dynamic prefixIcon;
  final controller;
  const ReusableField({
    Key? key,

    this.text,
    this.onSaved,
    this.controller,
    this.validator,
    this.onTapped,
    this.inputType,
    this.prefixIcon,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold, fontSize: 20),
              cursorHeight: 18,
              cursorColor: Colors.white,
              obscureText: obscureText,
              keyboardType: inputType,
              onTap: onTapped,
              controller: controller,
              onChanged: onSaved,
              validator: validator,
              decoration: InputDecoration(

                labelStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 18,
                  height: 4,
                ),
                prefixIcon: prefixIcon,
                labelText: text,
                prefixIconColor: Colors.white,
                filled: true,
                fillColor: Color(0xff38304D),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
