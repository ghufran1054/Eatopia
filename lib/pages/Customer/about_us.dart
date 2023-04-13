import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/utilities/custom_text_field.dart';
import 'package:flutter/material.dart';

class About_us extends StatefulWidget {
  const About_us({super.key});

  @override
  State<About_us> createState() => _About_usState();
}

class _About_usState extends State<About_us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
        backgroundColor: appGreen,
      ),
    );
  }
}
