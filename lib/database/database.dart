import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final String? uid;
  Database({this.uid});

  /// reference for collection....
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  /// for saving user data...
  Future savingUserData(
    String name,
    String email,
    String number,
    String image,
    uid,
  ) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      "name": name,
      "email": email,
      "profile_pic": image,
      "phone_number": number,
    });
  }

  /// getting user data...
  Future<DocumentSnapshot> gettingUserData() async {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get();
  }

  getUserMenu() {
    return userCollection.doc(uid).snapshots();
  }

  Future savingMenu(
    String foodName,
    String price,
    String foodImage,
    uid,
  ) async {
    await FirebaseFirestore.instance.collection('menu').doc(uid).set({
      "foodName": foodName,
      "price": price,
      "foodImage": foodImage,
      "userId": uid,
    });
  }
}
