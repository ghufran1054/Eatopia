import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatopia/pages/Restaurant/items.dart';
import 'package:eatopia/services/auth_services.dart';
import 'package:eatopia/services/db.dart';
import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/utilities/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'add_items.dart';

class ResItemsPage extends StatefulWidget {
  const ResItemsPage({super.key});

  @override
  State<ResItemsPage> createState() => _ResItemsPageState();
}

class _ResItemsPageState extends State<ResItemsPage>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  Map<String, List<Item>> ctgItems = {};

  void getCtgItems() async {
    ctgItems = await Db().getCtgItems(AuthServices().auth.currentUser!.uid);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCtgItems();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
        ? CustomShimmer(
            height: MediaQuery.of(context).size.height,
          )
        : Stack(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: ctgItems.keys.toList().length,
                    itemBuilder: (context, index) {
                      final ctg = ctgItems.keys.toList()[index];
                      return ExpansionTile(
                        backgroundColor: Colors.white,
                        maintainState: true,
                        title: Row(
                          children: [
                            Text(ctg,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'ubuntu-bold',
                                  color: Colors.black,
                                )),
                            const Spacer(),
                            IconButton(
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return buildEditCtg(
                                            context, ctgItems, index);
                                      });
                                  setState(() {});
                                },
                                icon: Icon(Icons.edit, color: Colors.black)),
                          ],
                        ),
                        children: ctgItems[ctg]!
                            .map((item) => item.buildItemCard())
                            .toList(),
                      );
                    }),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  foregroundColor: appGreen,
                  onPressed: () async {
                    Item? newItem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddItemPage(
                                  categories: ctgItems.keys.toList(),
                                )));
                    if (newItem != null) {
                      setState(() {
                        ctgItems[newItem.category]!.add(newItem);
                      });
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
  }
}

Widget buildEditCtg(
    BuildContext context, Map<String, List<Item>> ctgItems, int index) {
  bool isEnabled = true;
  final categories = ctgItems.keys.toList();
  final categoryControl = TextEditingController();
  categoryControl.text = categories[index];
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: const Text('Edit Category'),
    content: TextField(
      controller: categoryControl,
      decoration: const InputDecoration(hintText: 'Category Name'),
    ),
    actions: [
      TextButton(
        child: const Text('CANCEL'),
        onPressed: () {
          if (!isEnabled) {
            return;
          }
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('EDIT'),
        onPressed: () async {
          if (!isEnabled) {
            return;
          }
          String oldName = categories[index];
          categories[index] = categoryControl.text;
          Map<String, List<Item>> newCtgItems = {};
          for (String ctg in categories) {
            newCtgItems[ctg] = [];
          }
          for (String ctg in ctgItems.keys) {
            if (ctg == oldName) {
              newCtgItems[categoryControl.text] = ctgItems[ctg]!;
            } else {
              newCtgItems[ctg] = ctgItems[ctg]!;
            }
          }
          //Change the orignal Map
          ctgItems.clear();
          ctgItems.addAll(newCtgItems);

          for (Item item in ctgItems[categoryControl.text]!) {
            item.category = categoryControl.text;
            final doc = FirebaseFirestore.instance
                .collection('Restaurants')
                .doc(AuthServices().auth.currentUser!.uid)
                .collection('Items')
                .doc(item.itemId);

            await doc.update({'category': categoryControl.text});
          }
          final doc = FirebaseFirestore.instance
              .collection('Restaurants')
              .doc(AuthServices().auth.currentUser!.uid);
          categories[index] = categoryControl.text;
          await doc.update({
            "Categories": categories,
          });
          isEnabled = true;
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
