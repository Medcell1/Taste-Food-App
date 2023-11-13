import 'package:admin_taste/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'Login_Page.dart';
import 'SignUpPage.dart';

class HelloVendor extends StatelessWidget {
  const HelloVendor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: ( context, box, child) {
        final isDark = box.get('isDark' , defaultValue: false);
        return Scaffold(
          backgroundColor: isDark ? Color(0xff303436) : Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 100,
                child: Image.asset(
                  'assets/logobig.png',
                  scale: 0.5,
                  color: Colors.teal,
                ),
              ),

              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                    // Here is the explicit parent TextStyle
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    children:  <TextSpan>[
                      TextSpan(text: 'Hello, Welcome to ', style: TextStyle(
                        color: isDark? Colors.white: Colors.black,
                      )),
                      TextSpan(
                        text: ' CTaste ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text:
                        'Vendors Forum, to continue Sign Up or Log In to Your Account. ',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: isDark? Colors.white: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, left: 20),
                      height: 50,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style:
                          fontStyle.copyWith(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      height: 45,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Log In',
                          style: fontStyle.copyWith(
                              color: Colors.teal,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
