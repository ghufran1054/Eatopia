import 'dart:io';
import 'package:eatopia/pages/Restaurant/items.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Db {
  final db = FirebaseFirestore.instance;

  Future<List<String>> getRestaurantCategories(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .get();
    List<String> ctgs = List<String>.from(doc['Categories']);
    return ctgs;
  }

  Future<void> addItemInRestaurant(
      String uid, File imageFile, Map<String, dynamic> item) async {
    //This doc is the document reference of the item
    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .collection('Items')
        .add(item);

    //If there is no image file then place null in imageURl
    if (imageFile.path.isEmpty) {
      await doc.update({
        "ImageURL": null,
      });
      return;
    }
    // Get the file extension from the file path
    final String fileExtension = p.extension(imageFile.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child('RestaurantImages/$uid/itemImages/${doc.id}$fileExtension');

    final taskSnap = await ref.putFile(imageFile);
    final url = await taskSnap.ref.getDownloadURL();

    //Adding the image url to the database
    await doc.update({
      "ImageURL": url,
    });
  }

  Future<List<Item>> getRestaurantItems(String resId) async {
    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(resId)
        .collection('Items')
        .get();
    List<Item> items = [];
    for (var item in doc.docs) {
      items.add(Item(
        name: item['name'],
        price: item['price'],
        desc: item['desc'],
        ImageURL: item['ImageURL'],
        category: item['category'],
        addOns: item['addOns'],
      ));
    }

    return items;
  }
}
