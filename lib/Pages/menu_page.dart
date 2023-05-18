import 'package:admin_taste/Pages/menu_search_page.dart';
import 'package:admin_taste/Reusables/edit_menu_box.dart';
import 'package:admin_taste/model/menu_model.dart';
import 'package:admin_taste/provider/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Reusables/add_menu_box.dart';
import '../Reusables/menu_tile.dart';

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
  @override
  void initState() {
    MenuProvider mp = Provider.of(context, listen: false);
    mp.getUserInfo();
    print('uid------init${mp.userInfo?.uid}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Consumer<MenuProvider>(
          builder: (context, mp, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('menu')
                  .where(
                    'uid',
                    isEqualTo: user!.uid,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
                final docs = snapshot.data!.docs;
                final menuItems = docs
                    .map((doc) =>
                        MenuModel.fromMap(doc.data() as Map<String, dynamic>))
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
                                  fontSize: 30, color: Colors.white),
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
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: menuItems.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        menuItems
                            .sort((b, a) => b.dateTime!.compareTo(a.dateTime!));
                        return MenuTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return EditMenuBox(
                                      menuId: snapshot.data!.docs[index].id);
                                });
                          },
                          onLongTap: () {
                            mp.deleteMenu(snapshot.data!.docs[index].id);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.teal,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddMenuBox();
              });
        },
      ),
    );
  }
}
