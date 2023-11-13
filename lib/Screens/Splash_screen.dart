import 'dart:async';

import 'package:admin_taste/Screens/who_are_you.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Splash extends StatefulWidget {
  final dynamic value;
  final dynamic onChanged;
  final dynamic isDark;

  const Splash({Key? key, this.onChanged, this.value, this.isDark})
      : super(key: key);

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
      return UserProfilePage(
        onChanged: widget.onChanged,
        value: widget.value,
      );
    }), (route) => false);
  }

  @override
  void initState() {
    startTimeOut();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, child) {
        final isDark = box.get('isDark', defaultValue: false);
        return Scaffold(
          backgroundColor: isDark ? Color(0xff303436) : Colors.white,
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
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  LoadingAnimationWidget.dotsTriangle(
                      color: isDark ? Colors.white : Colors.black, size: 50)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
