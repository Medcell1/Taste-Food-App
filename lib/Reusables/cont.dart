import 'package:flutter/material.dart';

import '../constants.dart';

class ReusableContainer extends StatelessWidget {
  final dynamic index;
  const ReusableContainer({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 910,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: Colors.grey.shade100,
      ),
      child: storeDetails[index],
    );
  }
}
