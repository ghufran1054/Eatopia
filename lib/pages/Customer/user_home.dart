import 'package:eatopia/pages/Customer/user_more.dart';
import 'package:eatopia/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/pages/Customer/user_main_home.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<Widget> headings = [
    const Text('Home'),
    const Text('Cart'),
    const Text('More')
  ];
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
        title: headings[selectedIndex],
        backgroundColor: appGreen,
      ),
      body: [
        const UserMainHome(),
        const Center(
          child: Text('Favourites'),
        ),
        //const UserMorePage(),
        const UserMore(),
      ][selectedIndex],
    );
  }
}

//GUZARE KE LYE CLASS BNA RHA HU

class UserMorePage extends StatefulWidget {
  const UserMorePage({super.key});

  @override
  State<UserMorePage> createState() => _UserMorePageState();
}

class _UserMorePageState extends State<UserMorePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.business_center,
                    color: Colors.black,
                  ),
                  title: const Text('Register your Business'),
                  onTap: () {
                    Navigator.pushNamed(context, '/BuisnessSignup');
                  },
                )),
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text('Log out'),
                  onTap: () async {
                    await AuthServices().auth.signOut();
                    Navigator.pushReplacementNamed(context, '/WelcomePage');
                  },
                )),
          ],
        ),
      ),
    );
  }
}
