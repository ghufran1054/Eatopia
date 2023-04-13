import 'package:eatopia/utilities/colours.dart';
import 'package:flutter/material.dart';
import 'package:eatopia/utilities/custom_text_field.dart';

class User_profile extends StatefulWidget {
  const User_profile({super.key});

  @override
  State<User_profile> createState() => _User_profileState();
}

class _User_profileState extends State<User_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Maazi Bhai',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                buildCard(
                  title: 'Information',
                  child: Column(
                    children: [
                      buildInfoRow(
                        label: 'Email',
                        value: 'Maazi.ali@gmail.com',
                      ),
                      buildInfoRow(
                        label: 'Phone',
                        value: '+1 234 567 890',
                      ),
                      buildInfoRow(
                        label: 'Address',
                        value: 'New York, NY',
                      ),
                      SizedBox(height: 20),
                      ButtonBar(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appGreen,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // make a floating button
        ],
      ),
    );
  }
}

Widget buildCard({
  required String title,
  required Widget child,
}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    ),
  );
}

Widget buildInfoRow({
  required String label,
  required String value,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
