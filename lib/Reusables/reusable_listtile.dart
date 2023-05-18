import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final dynamic onTap;
  const ReusableListTile({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 30,
      ),
      horizontalTitleGap: 10,
      title: Text(
        text,
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
