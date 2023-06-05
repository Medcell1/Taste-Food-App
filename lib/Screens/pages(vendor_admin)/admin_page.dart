import 'package:admin_taste/Screens/pages(vendor_admin)/profile_page.dart';
import 'package:admin_taste/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Reusables/big_admin_util_box.dart';
import '../../Reusables/small_util_box_admin.dart';
import 'menu_page.dart';

enum Choose {
  first,
  second,
  third,
  fourth,
}

User? loggedInUser;

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  checkInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await InternetConnectionCheckerPlus().hasConnection);

    print(
        "Current status: ${await InternetConnectionCheckerPlus().connectionStatus}");
    var listener =
        InternetConnectionCheckerPlus().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 10),
              backgroundColor: Colors.red,
              content: Text(
                'No Internet Connection',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          break;
      }
    });
    await Future.delayed(
      Duration(seconds: 40),
    );
    await listener.cancel();
  }

  Choose? selected;
  Database db = Database();
  final auth = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  void getCurrentUser() {
    try {
      var user = auth;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    checkInternet();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.green],
          stops: [0.2, 1],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: height,
          width: width,
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              'Hi ${snapshot.data!['name'].toString()}',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  color: Color(0xff555555),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  snapshot.data!["profile_pic"]
                                          .toString()
                                          .isEmpty
                                      ? 'https://i.pinimg.com/564x/b7/4a/64/b74a649b1c6320fb87181d215b19d86e.jpg'
                                      : snapshot.data!["profile_pic"],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: width * 0.8,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: Icon(CupertinoIcons.search),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'Food Categories.',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                              fontSize: 25,
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallUtilBox(
                            height: height,
                            width: width,
                            onTap: () {
                              selected = Choose.first;
                              setState(() {});
                            },
                            assetUrl: 'assets/meat.png',
                            text: 'Meat',
                            containerColor: selected == Choose.first
                                ? Color(0xff539E83)
                                : Colors.white,
                            textColor: selected == Choose.first
                                ? Colors.white
                                : Colors.black,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          SmallUtilBox(
                            height: height,
                            width: width,
                            onTap: () {
                              selected = Choose.second;
                              setState(() {});
                            },
                            assetUrl: 'assets/burger.png',
                            text: 'FastFood',
                            containerColor: selected == Choose.second
                                ? Color(0xff539E83)
                                : Colors.white,
                            textColor: selected == Choose.second
                                ? Colors.white
                                : Colors.black,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          SmallUtilBox(
                            height: height,
                            width: width,
                            onTap: () {
                              selected = Choose.third;
                              setState(() {});
                            },
                            assetUrl: 'assets/sushi.png',
                            text: 'Sushi',
                            containerColor: selected == Choose.third
                                ? Color(0xff539E83)
                                : Colors.white,
                            textColor: selected == Choose.third
                                ? Colors.white
                                : Colors.black,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          SmallUtilBox(
                            height: height,
                            width: width,
                            onTap: () {
                              selected = Choose.fourth;
                              setState(() {});
                            },
                            assetUrl: 'assets/drinks.png',
                            text: 'Drinks',
                            containerColor: selected == Choose.fourth
                                ? Color(0xff539E83)
                                : Colors.white,
                            textColor: selected == Choose.fourth
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          BigUtilBox(
                            height: height,
                            width: width,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MenuPage();
                                  },
                                ),
                              );
                            },
                            text: 'Menu',
                            content: Image(
                              image: AssetImage('assets/adminfork.png'),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          BigUtilBox(
                            height: height,
                            width: width,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProfilePage();
                                  },
                                ),
                              );
                            },
                            text: 'Profile',
                            content: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          BigUtilBox(
                            height: height,
                            width: width,
                            text: 'Orders',
                            content: Icon(
                              Icons.shopping_cart_outlined,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          BigUtilBox(
                            height: height,
                            width: width,
                            text: 'Records',
                            content: Icon(
                              Icons.auto_graph,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("No data");
              } else if (snapshot.data == null) {
                return SizedBox(
                  height: height * 0.9,
                  child: Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return SizedBox(
                height: height * 0.9,
                child: Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Container(
//   height: 80,
//   width: 80,
//   decoration: BoxDecoration(
//     color: Colors.black,
//     borderRadius: BorderRadius.circular(100),
//     image: DecorationImage(
//       fit: BoxFit.cover,
//       image: NetworkImage(
//         snapshot.data!["profile_pic"].toString().isEmpty
//             ? 'https://i.pinimg.com/564x/b7/4a/64/b74a649b1c6320fb87181d215b19d86e.jpg'
//             : snapshot.data!["profile_pic"],
//       ),
//     ),
//   ),
// ),
