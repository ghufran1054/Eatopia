import 'package:eatopia/utilities/colours.dart';
import 'package:flutter/material.dart';

class Terms_policy extends StatefulWidget {
  const Terms_policy({super.key});

  @override
  State<Terms_policy> createState() => _Terms_policyState();
}

class _Terms_policyState extends State<Terms_policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Policies'),
        backgroundColor: appGreen,
      ),
    );
  }
}
