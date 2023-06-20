import 'package:admin_taste/provider/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Reusables/AdminUtils/edit_menu_box.dart';
import '../../Reusables/AdminUtils/menu_tile.dart';
import '../../model/menu_model.dart';

class MenuSearchPage extends StatefulWidget {
  const MenuSearchPage({Key? key}) : super(key: key);

  @override
  State<MenuSearchPage> createState() => _MenuSearchPageState();
}

class _MenuSearchPageState extends State<MenuSearchPage> {
  Stream<QuerySnapshot>? stream;
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController searchContoller = TextEditingController();

  List<MenuModel> _searchResults = [];
  String searchQuery = "";
  @override
  void initState() {
    // TODO: implement initState
    stream = FirebaseFirestore.instance
        .collection('menu')
        .where(
          'uid',
          isEqualTo: user!.uid,
        )
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(child: Consumer<MenuProvider>(
        builder: (context, mp, child) {
          return SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final docs = snapshot.data!.docs;
                final menuItems = docs
                    .map((doc) =>
                        MenuModel.fromMap(doc.data() as Map<String, dynamic>))
                    .toList();

                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  stream = FirebaseFirestore.instance
                                      .collection('menu')
                                      .where('uid', isEqualTo: user!.uid)
                                      .snapshots();
                                } else {
                                  print('$stream---->>>>before');
                                  stream = FirebaseFirestore.instance
                                      .collection('menu')
                                      .where(
                                        'uid',
                                        isEqualTo: user!.uid,
                                      )
                                      .where('foodName', isGreaterThan: value)
                                      .where('foodName',
                                          isLessThan: '$value\uf8ff')
                                      .snapshots();
                                  print('$stream---->>>>after');
                                }
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search For Notes',
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        // menuItems
                        //     .sort((b, a) => b.dateTime!.compareTo(a.dateTime!));
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        print(document);

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
                            // mp.deleteMenu(
                            //   snapshot.data!.docs[index].id,
                            // );
                          },
                          imageUrl: document['foodImage'],
                          one: document['foodName'],
                          two: document['price'],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      )),
    );
  }
}
