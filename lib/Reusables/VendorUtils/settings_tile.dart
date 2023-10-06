import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SettingsTile extends StatelessWidget {
   String text;
   Widget? icon;
   SettingsTile({super.key,  required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: SizedBox(
        height: height / 10,
        width: width/2,
        child: Card(
          color: Colors.white,
          child: Row(
            children: [
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
