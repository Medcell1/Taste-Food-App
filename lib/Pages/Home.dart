import 'package:flutter/material.dart';

import '../constants.dart';
import 'FirstPage.dart';
import 'SignUpPage.dart';

class PageSwiper extends StatefulWidget {
  final dynamic index;
  const PageSwiper({Key? key, required this.index}) : super(key: key);

  @override
  State<PageSwiper> createState() => _PageSwiperState();
}

class _PageSwiperState extends State<PageSwiper> {
  List imageList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imageList[widget.index],
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpPage();
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFE9B668),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(right: 10),
                    width: 150,
                    height: 70,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Register/Login as a Vendor',
                          style: khomepagetop,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Welcome to',
                style: khomepagemid,
              ),
              Text(
                'CTtaste...',
                style: khomepagemid,
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9B668),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const FirstPage();
                        },
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Proceed➟',
                      style: khomepagestyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
