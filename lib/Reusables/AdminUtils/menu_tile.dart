import 'package:admin_taste/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuTile extends StatelessWidget {
  final String imageUrl;
  final String one;
  final String two;
  final dynamic onTap;
  final dynamic onLongTap;

  const MenuTile({
    Key? key,
    required this.imageUrl,
    required this.one,
    required this.two,
    required this.onLongTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Consumer<MenuProvider>(
      builder: (context, mp, child) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 10),
          child: GestureDetector(
            onLongPress: onLongTap,
            onTap: onTap,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                // gradient: LinearGradient(
                //   colors: [
                //     Colors.green,
                //     Colors.white,
                //   ],
                //   stops: [0.2, 4],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                // gradient: LinearGradient(
                //   colors: [
                //     Colors.white,
                //     Color(0xff539E83).withOpacity(0.7),
                //   ],
                //   stops: [0.2, 1],
                //   begin: Alignment.bottomLeft,
                //   end: Alignment.topRight,
                // ),
              ),
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 11,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        one,
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 23,
                            color: Color(0xff4A5661),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(15)),
                        height: 32,
                        width: 65,
                        child: Center(
                          child: Text(
                            '#$two',
                            style: GoogleFonts.aclonica(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
