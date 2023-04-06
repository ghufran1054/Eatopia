import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          //margin: EdgeInsets.only(left: 350.0),
          child: Image.asset(
            'images/eatopia.png',
            //width: 550.0,
            //height: 550.0,
          ),
        ),
        Container(
            child: GredientButton(
                title: "Login",
                onPressed: () {},
                splashColor: Color(0xFFFF0000),
                colors: const [
              //Color(0xFFFF9500),
              Color.fromARGB(255, 0, 170, 255),
              Color(0xFF004292),
            ])),
        Container(
            child: GredientButton(
                title: "Sign Up",
                onPressed: () {},
                splashColor: Color.fromRGBO(255, 0, 0, 1),
                colors: const [
              Color(0xFFFF9500),
              Color.fromARGB(255, 0, 170, 255),
              Color.fromRGBO(255, 55, 55, 1),
            ])),
        Container(
            child: GredientButton(
                title: "Continue as a Guest",
                onPressed: () {},
                splashColor: Color.fromRGBO(255, 0, 0, 1),
                colors: const [
              Color(0xFFFF9500),
              Color.fromARGB(255, 0, 170, 255),
              Color.fromRGBO(255, 55, 55, 1),
            ]))
      ],
    ));
  }
}
