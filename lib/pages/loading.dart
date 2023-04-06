import 'package:eatopia/services/auth_services.dart';
import 'package:eatopia/utilities/colours.dart';
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
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image(image: AssetImage("images/eatopia.png"))],
          ),
          const SizedBox(height: 20),
          SpinKitThreeBounce(
            color: appGreen,
            size: MediaQuery.of(context).size.width / 50 +
                MediaQuery.of(context).size.height / 40,
          ),
        ],
      ),
    );
  }
}
