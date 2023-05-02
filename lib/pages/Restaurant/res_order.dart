import 'package:eatopia/utilities/colours.dart';
import 'package:flutter/material.dart';

class ResOrders extends StatefulWidget {
  const ResOrders({super.key});

  @override
  State<ResOrders> createState() => _ResOrdersState();
}

class _ResOrdersState extends State<ResOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResOrders'),
        backgroundColor: appGreen,
      ),
    );
  }
}
