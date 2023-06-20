import 'package:flutter/material.dart';

class AddBox extends StatelessWidget {
  final double height;
  final double width;
  final dynamic icon;
  final dynamic insets;
  final dynamic onTap;
  const AddBox(
      {Key? key,
      required this.height,
      required this.width,
      this.icon,
      this.insets,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: insets,
        width: width * 0.09,
        height: height * 0.04,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
