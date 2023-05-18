import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  // final dynamic one;
  // final dynamic two;
  // final dynamic three;
  // final String? one;
  final String? two;
  final String? three;
  ReusableText({Key? key, this.two, this.three}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   one!,
          //   style: TextStyle(
          //     color: Colors.yellow.shade700,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 17,
          //   ),
          // ),
          Text(two!),
          Text(three!),
        ],
      ),
    );
  }
}
