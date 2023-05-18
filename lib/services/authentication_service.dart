import 'package:admin_taste/database/database.dart';
import 'package:admin_taste/provider/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthServices {
  Database db = Database();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ///  sign up function .....
  Future signUpUser(
    String name,
    String email,
    String password,
    String number,
    String image,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      // await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      await db.savingUserData(
          name, email, number, image, userCredential.user!.uid);

      // User user = (await firebaseAuth.createUserWithEmailAndPassword(
      //         email: email, password: password))
      //     .user!;
      // if (user != null) {
      //   /// calling database services to update the user data...
      //   await Database(uid: user.uid).savingUserData(name, email);
      //   return true;
      // }

    } on FirebaseException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            animation: null,
            content: Text('Password is too weak'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            animation: null,
            content: Text('E-mail Provided already exists'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          animation: null,
          content: Text(
            e.toString(),
          ),
        ),
      );
      print(
        e.toString(),
      );
    }
  }

  Future logInUser(String email, String password, BuildContext context) async {
    String res = 'Some error';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        MenuProvider mp = Provider.of(context, listen: false);
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        res = 'Successful';
      }
    } on FirebaseException catch (e) {
      res = e.toString();
      print(res);
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wrong Password'),
          ),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No User found for this Email. '),
          ),
        );
      }
    }
    return res;
  }
}
