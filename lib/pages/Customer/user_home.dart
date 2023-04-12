import 'package:flutter/material.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/pages/Customer/user_main_home.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: appGreen,
        onTap: (index) => setState(() => selectedIndex = index),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text('User Home'),
        backgroundColor: appGreen,
      ),
      body: [
        const UserMainHome(),
        const Center(
          child: Text('Favourites'),
        ),
        Center(
          child: FloatingActionButton(onPressed: () {
            Navigator.pushNamed(context, '/BuisnessSignup');
          }),
        ),
      ][selectedIndex],
    );
  }
}
