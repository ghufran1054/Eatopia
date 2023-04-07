import 'package:eatopia/pages/loading.dart';
import 'package:eatopia/pages/user_sign_up.dart';
import 'package:flutter/material.dart';

import 'pages/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/WelcomePage',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/UserSignUpPageOne': (context) => const UserSignUpPageOne(),
        '/UserSignUpPageTwo': (context) => const UserSignUpPageTwo(),
        '/WelcomePage': (context) => const WelcomePage(),
      },
      theme: ThemeData(
        fontFamily: 'ubuntu',
      ),
    );
  }
}
