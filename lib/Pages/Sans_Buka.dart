import 'package:admin_taste/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Reusables/reusable_listtile.dart';
import '../provider/providers.dart';

class Sans extends StatefulWidget {
  const Sans({Key? key}) : super(key: key);
  @override
  State<Sans> createState() => _SansState();
}

class _SansState extends State<Sans> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF554535),
      body: Consumer<AuthProvider>(
        builder: (context, ap, _) {
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Text(
                        'CtTaste...',
                        style: GoogleFonts.pacifico(fontSize: 30),
                      ),
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data!["profile_pic"].toString().isEmpty
                                    ? 'https://i.pinimg.com/564x/b7/4a/64/b74a649b1c6320fb87181d215b19d86e.jpg'
                                    : snapshot.data!["profile_pic"],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        snapshot.data!["name"].toString(),
                        style: GoogleFonts.ubuntu(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ReusableListTile(
                        icon: Icons.home,
                        text: 'DashBoard',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ReusableListTile(
                        icon: Icons.cabin,
                        text: 'Product',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ReusableListTile(
                        icon: Icons.notification_important,
                        text: 'Notification',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ReusableListTile(
                        icon: Icons.help,
                        text: 'Help',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ReusableListTile(
                        onTap: () {
                          ap.logOut(context);
                        },
                        icon: Icons.login_outlined,
                        text: 'Log Out',
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("No data");
              } else if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
