import 'dart:async';

import 'package:admin_taste/Screens/pages(customer)/menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'kitchen_seearch_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

Stream<QuerySnapshot> refreshStream =
    FirebaseFirestore.instance.collection('users').snapshots();

class _FirstPageState extends State<FirstPage> {
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
      Duration(seconds: 30),
    );
    await listener.cancel();
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Future<void> handleRefresh() async {
      setState(() {
        refreshStream =
            FirebaseFirestore.instance.collection('users').snapshots();
      });
    }

    return Scaffold(
      body: LiquidPullToRefresh(
        backgroundColor: Colors.black,
        showChildOpacityTransition: false,
        color: Colors.white,
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: refreshStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                  height: height * 0.9,
                  child: Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return KitchenSearchPage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width * 0.05),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.grey),
                          ),
                          child: Icon(
                            CupertinoIcons.search,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.18,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/logobig.png',
                        ),
                        height: 30,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: width * 0.2,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.bell_solid,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: height * 0.17,
                    width: width * 0.9,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 10),
                              child: Column(
                                children: [
                                  Text(
                                    'Claim your daily',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'free delivery now!',
                                    style: GoogleFonts.kanit(
                                      fontSize: 20,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.black,
                              ),
                              child: Center(
                                child: Text(
                                  'Order Now',
                                  style: GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Image(
                            image: AssetImage(
                              'assets/burger-hungry.gif',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Featured',
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimationLimiter(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: documents.length,
                      padding: EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 2,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: () {
                                  if (snapshot.data?.docs[index].id != null ||
                                      documents[index]['name'] != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return VendorMenuScreen(
                                            vendorId:
                                                snapshot.data!.docs[index].id,
                                            vendorName: documents[index]
                                                ['name'],
                                            vendorNumber: documents[index]
                                                ['phone_number'],
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  print(
                                    documents[index]['phone_number'],
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          documents[index]['profile_pic'] ??
                                              'https://i.pinimg.com/564x/b7/4a/64/b74a649b1c6320fb87181d215b19d86e.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.7),
                                            ],
                                          ),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              15.0,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                documents[index]['name'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ), /* add child content here */
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
