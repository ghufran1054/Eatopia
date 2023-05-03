import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia/services/auth_services.dart';
import 'package:eatopia/services/db.dart';
import 'package:eatopia/services/maps.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eatopia/pages/Customer/user_res_page.dart';

class All_Res extends StatefulWidget {
  const All_Res({Key? key}) : super(key: key);
  @override
  State<All_Res> createState() => _All_ResState();
}

class _All_ResState extends State<All_Res> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Restaurants'),
        backgroundColor: appGreen,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Restaurants').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var res = snapshot.data!.docs[index];
              final doc = snapshot.data!.docs[index];
              String resDesc = (doc.data() as Map<String, dynamic>)
                      .containsKey('description')
                  ? doc['description']
                  : '';
              String imageURL =
                  (doc.data() as Map<String, dynamic>).containsKey('ImageURL')
                      ? doc['ImageURL']
                      : '';
              bool isOpen =
                  (doc.data() as Map<String, dynamic>).containsKey('isOpen')
                      ? doc['isOpen']
                      : false;
              String address = doc['address'];
              return Card(
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: InkWell(
                  onTap: () {
                    // navigate user res page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRestauarantPage(data: {
                                  'id': doc.id,
                                  'restaurant': doc['restaurant'],
                                  'image': imageURL,
                                  'description': resDesc,
                                  'address': address,
                                  'email': doc['email'],
                                  'phone': doc['phone'],
                                })));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100.0,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.0),
                            child: Image.network(
                              res['ImageURL'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          res['restaurant'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          res['address'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
