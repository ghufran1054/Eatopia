import 'package:eatopia/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final AuthServices _authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    _authServices.isSignedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 87, 126, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'EAT',
                style: TextStyle(
                  fontFamily: 'ubuntu',
                  fontSize: MediaQuery.of(context).size.width / 22.5 +
                      MediaQuery.of(context).size.height / 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'OPIA',
                style: TextStyle(
                  fontFamily: 'ubuntu',
                  fontSize: MediaQuery.of(context).size.width / 22.5 +
                      MediaQuery.of(context).size.height / 30,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SpinKitThreeBounce(
            color: Colors.white,
            size: MediaQuery.of(context).size.width / 50 +
                MediaQuery.of(context).size.height / 40,
          ),
        ],
      ),
    );
  }
}
