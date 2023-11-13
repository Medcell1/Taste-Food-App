import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigUtilBox extends StatelessWidget {
  final dynamic content;
  final String text;
  final dynamic onTap;
  final dynamic height;
  final dynamic width;
  const BigUtilBox(
      {Key? key,
      required this.content,
      required this.text,
      this.onTap,
      this.height,
      this.width,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(5.0, 7.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        width: width * 0.4,
        height: height * 0.22,
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 25),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff539E83).withOpacity(0.7),
                ),
                child: content,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              text,
              style: GoogleFonts.kanit(
                fontSize: 20,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
