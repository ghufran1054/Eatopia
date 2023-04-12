import 'package:eatopia/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:eatopia/utilities/colours.dart';

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
                  Navigator.pushNamed(context, '/LoginPage');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  // change background color of button
                  backgroundColor: appGreen, // change text color of button
                ),
                child: const Text("Login with Email"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/UserSignUpPageOne');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  // change background color of button
                  backgroundColor: appGreen, // change text color of button
                ),
                child: const Text("Sign up with Email"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/UserHomePage'); // /UserHomePage
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  foregroundColor: Colors.white,
                  // change background color of button
                  backgroundColor: appGreen, // change text color of button
                ),
                child: const Text("Continue as Guest"),
              ),
            ),
            Container(
              width: 200,
              height: 1.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(255, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Colors.white,
                // change background color of button
                backgroundColor: Colors.white, // change text color of button
              ),
              onPressed: () {
                AuthServices().signInWithGoogle(context: context);
              },
              label: const Text(
                "Continue with Google",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              icon: Image.asset(
                'images/google.png',
                height: 30,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
