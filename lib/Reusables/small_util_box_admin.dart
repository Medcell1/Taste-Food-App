import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallUtilBox extends StatelessWidget {
  final String assetUrl;
  final String text;
  final dynamic onTap;
  final dynamic containerColor;
  final dynamic textColor;
  const SmallUtilBox({
    Key? key,
    required this.assetUrl,
    required this.text,
    this.onTap,
    this.containerColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        width: 90,
        height: 115,
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage(assetUrl),
              ),
              Text(
                text,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
