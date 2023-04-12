import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia/services/auth_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ResHome extends StatefulWidget {
  const ResHome({super.key});

  @override
  State<ResHome> createState() => _ResHomeState();
}

class _ResHomeState extends State<ResHome> {
  late Size scrSize;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    scrSize = MediaQuery.of(context).size;

    return isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Restaurant Home'),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView(
                  children: const [
                    //Image Select Widget
                    ImageSelectWidget(),
                    SizedBox(height: 20),
                    //Category Container showing existing categories and add category button, remove the category, rename the category
                    CategoriesWidget(),
                  ],
                ),
              ),
            ),
          );
  }
}

class ImageSelectWidget extends StatefulWidget {
  const ImageSelectWidget({super.key});

  @override
  State<ImageSelectWidget> createState() => _ImageSelectWidgetState();
}

class _ImageSelectWidgetState extends State<ImageSelectWidget> {
  Future<void> loadImage() async {
    final String uid = AuthServices().auth.currentUser!.uid;
    final doc = FirebaseFirestore.instance.collection('Restaurants').doc(uid);
    final data = await doc.get();
    isLoading = true;
    try {
      final url = data.get('ImageURL');
      setState(() {
        imageURL = url;
        isImageLoaded = true;
      });
    } catch (e) {
      isImageLoaded = false;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> imagePicker() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile = File(picked.path);
      setState(() {
        isImageLoaded = true;
      });

      final String uid = AuthServices().auth.currentUser!.uid;
      // Get the file extension from the file path
      final String fileExtension = p.extension(imageFile!.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('RestaurantImages/$uid/ResImage$fileExtension');

      setState(() {
        isLoading = true;
      });
      final taskSnap = await ref.putFile(imageFile!);
      final url = await taskSnap.ref.getDownloadURL();

      //Adding the image url to the database
      final doc = FirebaseFirestore.instance.collection('Restaurants').doc(uid);
      await doc.update({
        "ImageURL": url,
      });

      setState(() {
        imageURL = url;
        isLoading = false;
      });
    }
  }

  final picker = ImagePicker();
  late Size scrSize;
  late File? imageFile = File('');
  late String? imageURL;
  bool isImageLoaded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    scrSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      height: 250,
      width: scrSize.width,
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Restauarant Image',
                style: TextStyle(fontFamily: 'ubuntu-bold', fontSize: 20),
              ),
              const Spacer(),
              IconButton(onPressed: imagePicker, icon: Icon(Icons.edit)),
            ],
          ),
          isLoading
              ? const SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator())
              : (!isImageLoaded
                  ? Center(
                      child: TextButton(
                      child: Text('Upload a Photo'),
                      onPressed: imagePicker,
                    ))
                  : Container(
                      height: 150,
                      width: scrSize.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(imageURL!)),
                      ),
                    )),
        ],
      ),
    );
  }
}

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  List<String> categories = [];
  bool isLoading = true;

  Future<void> addCategory(String text) async {
    final doc = FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(AuthServices().auth.currentUser!.uid);
    await doc.update({
      "Categories": FieldValue.arrayUnion([text])
    });

    setState(() {
      categories.add(text);
    });
  }

  Future<void> removeCategory(int index) async {
    final doc = FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(AuthServices().auth.currentUser!.uid);

    await doc.update({
      "Categories": FieldValue.arrayRemove([categories[index]])
    });

    setState(() {
      categories.removeAt(index);
    });
  }

  Future<void> getCategories() async {
    categories = [];

    final doc = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(AuthServices().auth.currentUser!.uid)
        .get();
    List<dynamic> fetchedCategories = doc['Categories'];
    for (var cat in fetchedCategories) {
      categories.add(cat);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final Size scrSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      width: scrSize.width,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isLoading
          ? const Center(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: const CircularProgressIndicator()))
          : Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(fontFamily: 'ubuntu-bold', fontSize: 20),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final categoryControl = TextEditingController();
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: const Text('Create Category'),
                                content: TextField(
                                  controller: categoryControl,
                                  decoration: const InputDecoration(
                                      hintText: 'Category Name'),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('CANCEL'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('CREATE'),
                                    onPressed: () async {
                                      await addCategory(categoryControl.text);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),

                //Category List
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: max(categories.length, 1),
                    itemBuilder: (context, index) {
                      return categories.isEmpty
                          ? const SizedBox(
                              height: 300,
                              child: Center(child: Text('No Categories!')))
                          : Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                leading: SizedBox(
                                  width: 20,
                                  child: IconButton(
                                    iconSize: 20,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            final categoryControl =
                                                TextEditingController();
                                            categoryControl.text =
                                                categories[index];
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              title:
                                                  const Text('Edit Category'),
                                              content: TextField(
                                                controller: categoryControl,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            'Category Name'),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('CANCEL'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('EDIT'),
                                                  onPressed: () async {
                                                    final doc =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Restaurants')
                                                            .doc(AuthServices()
                                                                .auth
                                                                .currentUser!
                                                                .uid);
                                                    await doc.update({
                                                      "Categories": FieldValue
                                                          .arrayRemove([
                                                        categories[index]
                                                      ]),
                                                    });
                                                    await doc.update({
                                                      "Categories": FieldValue
                                                          .arrayUnion([
                                                        categoryControl.text
                                                      ]),
                                                    });
                                                    setState(() {
                                                      categories[index] =
                                                          categoryControl.text;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                                tileColor: Colors.white,
                                title: Text(categories[index]),
                                trailing: IconButton(
                                  onPressed: () async {
                                    await removeCategory(index);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
