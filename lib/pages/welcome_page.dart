import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(30),
          alignment: Alignment.topCenter,
          //margin: EdgeInsets.only(left: 350.0),
          child: Image.asset(
            'images/eatopia.png',
            width: 250.0,
            height: 250.0,
          ),
        ),

        Container(
          margin: EdgeInsets.all(20.0),
          width: 180,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              // change background color of button
              backgroundColor: appGreen, // change text color of button
            ),
            child: Text("Login"),
          ),
        ),

        Container(
          margin: EdgeInsets.all(20.0),
          width: 180,
          height: 50,
          color: appGreen,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              // change background color of button
              backgroundColor: appGreen, // change text color of button
            ),
            child: Text("Sign Up"),
          ),
        ),

        Container(
          margin: EdgeInsets.all(20.0),
          width: 180,
          height: 50,
          color: appGreen,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
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
        // Container(
        //     margin: EdgeInsets.all(20.0),
        //     width: 160,
        //     child: GredientButton(
        //         title: "Continue as a Guest",
        //         onPressed: () {},
        //         splashColor: Color.fromRGBO(255, 0, 0, 1),
        //         colors: const [
        //           Color.fromARGB(255, 1, 109, 57),
        //           Color.fromRGBO(175, 40, 40, 1)
        //         ])),
      ],
    ));
  }
}
