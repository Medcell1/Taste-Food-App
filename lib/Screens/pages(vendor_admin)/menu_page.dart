import 'package:admin_taste/Reusables/AdminUtils/add_menu_box.dart';
import 'package:admin_taste/Reusables/AdminUtils/edit_menu_box.dart';
import 'package:admin_taste/model/menu_model.dart';
import 'package:admin_taste/provider/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../Reusables/AdminUtils/menu_tile.dart';
import 'menu_search_page.dart';

XFile? file;
final user = FirebaseAuth.instance.currentUser;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MenuPage extends StatefulWidget {
  MenuPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          print('No Internet connection');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
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

  Stream<QuerySnapshot> refreshStream = FirebaseFirestore.instance
      .collection('menu')
      .where(
        'uid',
        isEqualTo: user!.uid,
      )
      .snapshots();
  Future<void> handleRefresh() async {
    setState(() {
      refreshStream = FirebaseFirestore.instance
          .collection('menu')
          .where(
            'uid',
            isEqualTo: user!.uid,
          )
          .snapshots();
    });
  }

  @override
  void initState() {
    checkInternet();
    MenuProvider mp = Provider.of(context, listen: false);
    mp.getUserInfo();
    print('uid------init${mp.userInfo?.uid}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: LiquidPullToRefresh(
          color: Colors.teal,
          showChildOpacityTransition: false,
          onRefresh: handleRefresh,
          child: SingleChildScrollView(
            child: Consumer<MenuProvider>(
              builder: (context, mp, child) {
                return StreamBuilder<QuerySnapshot>(
                  stream: refreshStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.9,
                            child: Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.9,
                            child: Center(
                              child: LoadingAnimationWidget.dotsTriangle(
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    final docs = snapshot.data!.docs;
                    final menuItems = docs
                        .map((doc) => MenuModel.fromMap(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 30),
                                child: Text(
                                  'Menu',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 32,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MenuSearchPage();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.search_rounded,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: menuItems.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            // menuItems
                            //     .sort((b, a) => b.dateTime!.compareTo(a.dateTime!));
                            return MenuTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return EditMenuBox(
                                          menuId:
                                              snapshot.data!.docs[index].id);
                                    });
                              },
                              onLongTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Are you sure you want to delete?'),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              await snapshot
                                                  .data!.docs[index].reference
                                                  .delete();
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: const Text('No'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              imageUrl: menuItems[index].foodImage!,
                              one: menuItems[index].foodName!,
                              two: menuItems[index].price!,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddMenuBox();
                });
          },
        ),
      ),
    );
  }
}
