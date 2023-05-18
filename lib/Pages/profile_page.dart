import 'package:admin_taste/Reusables/container.dart';
import 'package:admin_taste/provider/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    AuthProvider ap = Provider.of(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff539E83),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.heart,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Color(0xff539E83),
      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData ||
                snapshot.connectionState == ConnectionState.done) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: UtilContainer(
                  width: width,
                  height: height,
                  content: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(3.0, 8.0), //(x,y)
                          blurRadius: 10.0,
                        ),
                      ],
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
                  name: snapshot.data!['name'].toString(),
                  number: snapshot.data!['phone_number'].toString(),
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else if (snapshot.data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: Text('Can get Data!'),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
