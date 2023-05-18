import 'package:flutter/material.dart';

class ReusableField extends StatelessWidget {
  final dynamic one;
  final dynamic two;
  final dynamic three;
  final dynamic validator;
  final dynamic onSaved;
  final dynamic onTapped;
  final controller;
  const ReusableField(
      {Key? key,
      required this.one,
      this.two,
      this.three,
      this.onSaved,
      this.controller,
      this.validator,
      this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                Text(
                  one,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  two,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              onTap: onTapped,
              controller: controller,
              onChanged: onSaved,
              validator: validator,
              decoration: InputDecoration(
                hintText: three,
                filled: true,
                fillColor: Colors.teal.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
