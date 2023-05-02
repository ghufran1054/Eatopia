import 'dart:io';
import 'package:eatopia/pages/Restaurant/items.dart';
import 'package:eatopia/pages/Restaurant/search_result_class.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Db {
  final db = FirebaseFirestore.instance;

  Future<void> updateUserAddress(String uid, String add) async {
    await db.collection('Customers').doc(uid).update({'stAddress': add});
  }

  Future<void> updateRestaurantAddress(String uid, String add) async {
    await db.collection('Restaurants').doc(uid).update({'address': add});
  }

  Future<List<SearchResult>> searchRestauarants(String query) async {
    query = query.toLowerCase();
    //item collection ref
    final itemCollectionRef = db.collectionGroup('Items');
    final itemQuerySnapshot = await itemCollectionRef
        .where('nameArray', arrayContainsAny: query.split(RegExp(r'[\s,-]')))
        .get();

    Map<String, SearchResult> restContainingItem = {};

    for (final itemDoc in itemQuerySnapshot.docs) {
      final restDoc = await itemDoc.reference.parent.parent!.get();
      final restName = restDoc['restaurant'];
      if (!restContainingItem.containsKey(restName)) {
        Map<String, dynamic> restDocData = restDoc.data()!;
        restDocData['id'] = restDoc.id;
        restContainingItem[restName] =
            SearchResult(restDoc: restDocData, items: []);
      }
      restContainingItem[restName]!.items.add(Item(
            itemId: itemDoc.id,
            name: itemDoc['name'],
            price: itemDoc['price'],
            desc: itemDoc['desc'],
            ImageURL: itemDoc['ImageURL'],
            addOns: itemDoc['addOns'],
            category: itemDoc['category'],
          ));
    }

    //Gets Restaurants that start with the query
    // final resultPrefixed = await db
    //     .collection('Restaurants')
    //     .where('restaurantLower', isGreaterThanOrEqualTo: query)
    //     .where('restaurantLower', isLessThanOrEqualTo: '$query\uf8ff')
    //     .get();

    final resultContains = await db
        .collection('Restaurants')
        .where('restaurantArray',
            arrayContainsAny: query.split(RegExp(r'[\s,-]')))
        .get();

    // for (final doc in resultPrefixed.docs) {
    //   final restName = doc['restaurant'];
    //   if (!restContainingItem.containsKey(restName)) {
    //     Map<String, dynamic> restDocData = doc.data();
    //     restDocData['id'] = doc.id;
    //     restContainingItem[restName] =
    //         SearchResult(restDoc: restDocData, items: []);
    //   }
    // }

    for (final doc in resultContains.docs) {
      final restName = doc['restaurant'];
      if (!restContainingItem.containsKey(restName)) {
        restContainingItem[restName] =
            SearchResult(restDoc: doc.data(), items: []);
      }
    }

    return restContainingItem.values.toList();
  }

  Future<bool> getIsOpenStatus(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .get();
    return (doc.data() as Map<String, dynamic>).containsKey('isOpen')
        ? doc['isOpen']
        : false;
  }

  Future<void> toggleOpenStatus(String uid, bool isOpen) async {
    final doc = FirebaseFirestore.instance.collection('Restaurants').doc(uid);
    await doc.update({'isOpen': isOpen});
  }

  Future<List<String>> getRestaurantCategories(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .get();
    List<String> ctgs = List<String>.from(doc['Categories']);
    return ctgs;
  }

  Future<void> deleteItem(String uid, String itemId) async {
    final doc = FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .collection('Items')
        .doc(itemId);
    await doc.delete();
  }

  Future<Item> updateItem(String uid, File imageFile, String itemId,
      Map<String, dynamic> item) async {
    //This doc is the document reference of the item
    item['nameLower'] = item['name'].toString().toLowerCase();
    item['nameArray'] = item['nameLower'].toString().split(RegExp(r'[\s,-]'));
    final doc = FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .collection('Items')
        .doc(itemId);

    //If there is no image file then just update with item Map
    if (imageFile.path.isEmpty) {
      await doc.update(item);
      return Item(
        itemId: doc.id,
        name: item['name'],
        price: item['price'],
        desc: item['desc'],
        ImageURL: item['ImageURL'],
        category: item['category'],
        addOns: item['addOns'],
      );
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

    return Item(
      itemId: doc.id,
      name: item['name'],
      price: item['price'],
      desc: item['desc'],
      ImageURL: url,
      category: item['category'],
      addOns: item['addOns'],
    );
  }

  Future<Item> addItemInRestaurant(
      String uid, File imageFile, Map<String, dynamic> item) async {
    item['nameLower'] = item['name'].toString().toLowerCase();
    item['nameArray'] = item['nameLower'].toString().split(RegExp(r'[\s,-]'));
    //This doc is the document reference of the item
    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(uid)
        .collection('Items')
        .add(item);

    //If there is no image file then place null in imageURl
    if (imageFile.path.isEmpty) {
      await doc.update({
        "ImageURL": '',
      });
      return Item(
        itemId: doc.id,
        name: item['name'],
        price: item['price'],
        desc: item['desc'],
        ImageURL: '',
        category: item['category'],
        addOns: item['addOns'],
      );
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

    return Item(
      itemId: doc.id,
      name: item['name'],
      price: item['price'],
      desc: item['desc'],
      ImageURL: url,
      category: item['category'],
      addOns: item['addOns'],
    );
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
        itemId: item.id,
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

  //This functions sets the Map with ctgs as keys and list of items as a value
  Future<Map<String, List<Item>>> getCtgItems(String resId) async {
    Map<String, List<Item>> ctgItems = {};
    List<String> categories = await Db().getRestaurantCategories(resId);
    List<Item> items = await Db().getRestaurantItems(resId);
    for (var ctg in categories) {
      ctgItems[ctg] = [];
    }
    for (var item in items) {
      ctgItems[item.category]!.add(item);
    }
    return ctgItems;
  }
}
