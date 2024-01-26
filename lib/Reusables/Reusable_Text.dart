import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String? two;
  final String? three;
  ReusableText({Key? key, this.two, this.three}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(two!),
          Text(three!),
        ],
      ),
    );
  }
}
