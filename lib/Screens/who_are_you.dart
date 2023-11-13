import 'package:admin_taste/Screens/pages(vendor_admin)/hello_vendor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../Reusables/nav_bar.dart';

class UserProfilePage extends StatelessWidget {
  final dynamic onChanged;
  final dynamic value;


  const UserProfilePage({Key? key, this.onChanged, this.value, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("settings").listenable(),
      builder: (context, box, child) {
        var isDark = box.get("isDark" , defaultValue: false);
        return Scaffold(
          backgroundColor: isDark ? Color(0xff303436) : Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HelloVendor()),
                          (route) => false);
                },
                child: Center(
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xff539E83),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 15),
                        child: Text(
                          'Vendor',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavBar(
                          onChanged: onChanged,
                          value: value,

                        ),
                      ),
                          (route) => false);
                },
                child: Center(
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.teal,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 20, bottom: 15),
                        child: Text(
                          'Customer',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}
