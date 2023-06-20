import 'package:flutter/material.dart';

class MenuField extends StatelessWidget {
  final dynamic one;
  final dynamic two;
  final dynamic three;
  final dynamic validator;
  final dynamic onSaved;
  final dynamic onTapped;
  final controller;
  final dynamic keyType;
  const MenuField(
      {Key? key,
      required this.one,
      this.two,
      this.three,
      this.onSaved,
      this.controller,
      this.validator,
      this.onTapped,
      this.keyType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Row(
              children: [
                Text(
                  one,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xFF3A4068),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  two,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: SizedBox(
              height: 40,
              width: 700,
              child: TextFormField(
                keyboardType: keyType,
                onTap: onTapped,
                controller: controller,
                onChanged: onSaved,
                validator: validator,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    height: 1,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                  hintText: three,
                  hintStyle: TextStyle(
                    color: Color(0XffBCB8B2),
                    fontWeight: FontWeight.w900,
                  ),
                  filled: true,
                  fillColor: Color(0xffDCDAD7),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
