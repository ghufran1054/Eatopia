import 'dart:developer';
import 'package:eatopia/pages/Customer/user_home.dart';
import 'package:eatopia/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  //Recieves the Customer information Map
  Future<void> addCustomers(Map<String, dynamic> data) async {
    await db.collection('Customers').doc(auth.currentUser!.uid).set(data);
  }

  void isSignedIn(BuildContext context) async {
    await auth.signOut();
    await Future.delayed(const Duration(seconds: 3), () {
      if (auth.currentUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UserHomePage()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const WelcomePage()));
      }
    });
  }

  Future<bool> emailExists(String email) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email, password: "someBOdyNeverGOOnnaUsEthisPassWOrDDMDK");
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      switch (e.code) {
        case "user-not-found":
          return false;
      }
    }
    return true;
  }

  Future<void> signUpwithEmail(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return;
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account already exists'),
            ),
          );
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid Credential'),
            ),
          );
        }
      } catch (e) {
        return null;
        // handle the error here
      }
    }

    return user;
  }
}
