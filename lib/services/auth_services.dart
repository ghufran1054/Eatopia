import 'package:eatopia/pages/user_sign_up.dart';
import 'package:eatopia/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class AuthServices {
  void isSignedIn(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const UserSignUpPageOne()));
  }
}
