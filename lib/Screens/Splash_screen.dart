import 'dart:async';

import 'package:admin_taste/Screens/who_are_you.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimeOut() {
    return Timer(Duration(seconds: 5), navigate);
  }

  void navigate() {
    changeScreen();
  }

  changeScreen() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return UserProfilePage();
    }), (route) => false);
  }

  @override
  void initState() {
    startTimeOut();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'CtTaste...',
                    textStyle: GoogleFonts.allura(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ],
              ),
              LoadingAnimationWidget.dotsTriangle(color: Colors.black, size: 50)
            ],
          ),
        ],
      ),
    );
  }
}
