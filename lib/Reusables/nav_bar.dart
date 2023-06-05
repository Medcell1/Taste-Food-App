import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Screens/cart_page.dart';
import '../Screens/pages(customer)/FirstPage.dart';
import '../Screens/pages(vendor_admin)/hello_vendor.dart';
import '../Screens/who_are_you.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var currentIndex = 0;
  final List<Widget> _pages = [
    FirstPage(),
    UserProfilePage(),
    HelloVendor(),
    CartPage(),
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(width * .05),
        height: width * .185,
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: Offset(0, 10),
            ), // BoxShadow
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          padding: EdgeInsets.symmetric(horizontal: width * .02),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  currentIndex = index;
                  HapticFeedback.lightImpact();
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == currentIndex ? width * .32 : width * .18,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == currentIndex ? width * .12 : 0,
                      width: index == currentIndex ? width * .32 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? Colors.blueAccent.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == currentIndex ? width * .31 : width * .18,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == currentIndex ? width * .13 : 0,
                            ),
                            AnimatedOpacity(
                              curve: Curves.fastLinearToSlowEaseIn,
                              opacity: index == currentIndex ? 1 : 0,
                              duration: Duration(seconds: 1),
                              child: Text(
                                index == currentIndex
                                    ? '${listOfStrings[index]}'
                                    : '',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              width: index == currentIndex ? width * .03 : 20,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: Duration(seconds: 1),
                            ),
                            Icon(
                              listofIcons[index],
                              size: width * .076,
                              color: index == currentIndex
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

List<String> listOfStrings = [
  'Home',
  'Home',
  'Home',
  'Home',
];
List<IconData> listofIcons = [
  Icons.home,
  Icons.markunread_rounded,
  Icons.menu,
  Icons.notifications,
];
