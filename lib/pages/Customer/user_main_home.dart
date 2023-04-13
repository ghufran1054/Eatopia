import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/utilities/custom_tiles.dart';

class UserMainHome extends StatefulWidget {
  const UserMainHome({super.key});

  @override
  State<UserMainHome> createState() => _UserMainHomeState();
}

class _UserMainHomeState extends State<UserMainHome> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
              color: appGreen,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3)),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              cursorColor: Colors.black,
              controller: searchController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              //Container for Displaying tiles
              Container(
                constraints: const BoxConstraints(minHeight: 200),
                padding: const EdgeInsets.all(10),
                color: Colors.grey[200],
                height: scrSize.height * 0.3,
                width: scrSize.width,
                child: Center(
                  //Displaying Tiles inside it.
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTile(
                              size: Size(
                                  scrSize.width * 0.4, scrSize.height * 0.23),
                              heading: 'Food Delivery',
                              description:
                                  'Order food from your favourite restaurants',
                              icon: const Icon(
                                Icons.delivery_dining_rounded,
                                size: 30,
                              )),
                          CustomTile(
                              size: Size(
                                  scrSize.width * 0.4, scrSize.height * 0.23),
                              heading: 'Dine-in',
                              description: 'Make Reservations and eat out!',
                              icon: const Icon(
                                Icons.restaurant,
                                size: 30,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: scrSize.width,
                height: scrSize.height * 0.4,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text(
                            'Restaurants',
                            style: TextStyle(
                                fontFamily: 'Ubuntu-bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'View All',
                                style: TextStyle(
                                    color: appGreen,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Expanded(child: RestaurantTiles()),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RestaurantTiles extends StatefulWidget {
  const RestaurantTiles({super.key});

  @override
  State<RestaurantTiles> createState() => _RestaurantTilesState();
}

class _RestaurantTilesState extends State<RestaurantTiles> {
  @override
  Widget build(BuildContext context) {
    // Create a reference to the collection
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Restaurants');

// Build a stream of QuerySnapshot containing all the documents in the collection
    Stream<QuerySnapshot> stream = collectionRef.snapshots();
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];

                return ImageTile(
                  heading: doc['restaurant'],
                  description: doc['description'],
                  image: doc['ImageURL'],
                );
              },
              scrollDirection: Axis.horizontal,
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
// const [
//                             ImageTile(
//                                 heading: 'KFC',
//                                 description: 'Burgers, Chicken, Fries',
//                                 image: 'images/res.jpeg'),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             ImageTile(
//                                 heading: 'Pizza Hut',
//                                 description: 'Burgers, Chicken, Fries',
//                                 image: 'images/res.jpeg'),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             ImageTile(
//                                 heading: 'KFC',
//                                 description:
//                                     'Burgers, Chicken, Fries, kdskjk asdjnnjjnas nasjnjnsadjnn jnasjd',
//                                 image: 'images/res.jpeg'),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                           ]