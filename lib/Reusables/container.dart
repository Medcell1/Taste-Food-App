import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class UtilContainer extends StatelessWidget {
  final dynamic height;
  final dynamic width;
  final String name;
  final String number;
  final dynamic content;
  const UtilContainer(
      {Key? key,
      this.height,
      this.content,
      this.width,
      required this.name,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider ap = Provider.of(context, listen: false);
    return Stack(
      children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          height: height * 0.84,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 120),
          child: Column(
            children: [
              content,
            ],
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: height - 650),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              width: width,
              height: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.person_outline,
                    size: 35,
                    color: Colors.teal,
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                  Text(
                    name,
                    style:
                        GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              width: width,
              height: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.mail,
                    size: 40,
                    color: Colors.teal,
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                  Text('Info@ct.com',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(fontSize: 20))),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              width: width,
              height: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.phone_android_outlined,
                    size: 40,
                    color: Colors.teal,
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                  Text(number,
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(fontSize: 20))),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              width: width,
              height: 70,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image(
                    image: AssetImage(
                      'assets/insta.png',
                    ),
                    height: 40,
                    color: Colors.teal,
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                  Text('Instagram Account',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(fontSize: 20))),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                ap.logOut(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                width: width,
                height: 70,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.logout,
                      size: 40,
                      color: Colors.teal,
                    ),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    Text(
                      'Log Out',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
