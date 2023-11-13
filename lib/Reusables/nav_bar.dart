import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Screens/pages(customer)/FirstPage.dart';
import '../Screens/pages(customer)/message_page.dart';

class NavBar extends StatefulWidget {
  final dynamic onChanged;
  final dynamic value;
  final dynamic isDark;
  const NavBar({Key? key, this.onChanged, this.value, this.isDark}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var currentIndex = 0;

  @override

  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      FirstPage(onChanged: widget.onChanged, value: widget.value, isDark: widget.isDark,),
      MessagePage(),
    ];
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(width * .09),
        height: width * .175,
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
          itemCount: 2,
          padding: EdgeInsets.symmetric(horizontal: width * .15),
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
                                    color: Colors.green,
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
  'Mail',
];
List<IconData> listofIcons = [
  Icons.home,
  Icons.markunread_rounded,
];
