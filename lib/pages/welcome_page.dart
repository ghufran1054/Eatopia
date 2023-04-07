import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/eatopia.png',
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.pushNamed(context, '/LoginPage');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(180, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  // change background color of button
                  backgroundColor: appGreen, // change text color of button
                ),
                child: const Text("Login"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/UserSignUpPageOne');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(180, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  // change background color of button
                  backgroundColor: appGreen, // change text color of button
                ),
                child: const Text("Sign Up"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.pushNamed(context, '/HomePage');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(180, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  // change background color of button
                  backgroundColor: appGreen, // change text color of button
                ),
                child: Text("Continue as Guest"),
              ),
            ),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            ),
          ],
        ),
      ),
    ));
  }
}
