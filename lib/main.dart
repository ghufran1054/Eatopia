import 'package:eatopia/pages/loading.dart';
import 'package:eatopia/pages/login.dart';
import 'package:eatopia/pages/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:eatopia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/UserSignUpPageOne': (context) => const UserSignUpPageOne(),
        '/UserSignUpPageTwo': (context) => const UserSignUpPageTwo(),
        '/WelcomePage': (context) => const WelcomePage(),
        '/LoginPage': (context) => const LoginPage(),
      },
      theme: ThemeData(
        fontFamily: 'ubuntu',
      ),
    );
  }
}
