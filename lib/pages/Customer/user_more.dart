import 'package:eatopia/services/auth_services.dart';
import 'package:eatopia/services/db.dart';
import 'package:eatopia/services/maps.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:flutter/material.dart';

class UserMore extends StatefulWidget {
  const UserMore({super.key});
  @override
  State<UserMore> createState() => _UserMoreState();
}

class _UserMoreState extends State<UserMore> {
  List<String> value = [
    'Profile',
    'Address',
    'Create Business Account',
    'Terms and Policies',
    'About us',
    'Logout'
  ];

  //create a list containing the name and icon
  List<IconData> icons = [
    Icons.person,
    Icons.location_on,
    Icons.business,
    Icons.policy,
    Icons.info,
    Icons.logout
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  value[index],
                  style: const TextStyle(fontSize: 15),
                ),
                tileColor: appGreen,
                textColor: Colors.white,
                dense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Icon(icons[index]),
                iconColor: Colors.white,
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  if (value[index] == 'Profile') {
                    Navigator.pushNamed(context, '/User_profile');
                  } else if (value[index] == 'Create Business Account') {
                    Navigator.pushNamed(context, '/BuisnessSignup');
                  } else if (value[index] == 'Terms and Policies') {
                    Navigator.pushNamed(context, '/Terms_policy');
                  } else if (value[index] == 'About us') {
                    Navigator.pushNamed(context, '/About_us');
                  } else if (value[index] == 'Logout') {
                    await AuthServices().auth.signOut();
                    Navigator.pushReplacementNamed(context, '/WelcomePage');
                  } else if (value[index] == 'Address') {
                    String? locTxt = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapScreen(),
                        ));
                    if (locTxt != null &&
                        AuthServices().auth.currentUser != null) {
                      await Db().updateUserAddress(
                          AuthServices().auth.currentUser!.uid, locTxt);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: appGreen,
                          content: Text('Address Updated!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
              ),
            );
          }),
    ));
  }
}
