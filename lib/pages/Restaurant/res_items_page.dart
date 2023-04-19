import 'dart:io';
import 'dart:math';

import 'package:eatopia/utilities/colours.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utilities/custom_text_field.dart';

String? priceValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter price';
  }
  if (double.tryParse(value) == null) {
    return 'Please enter a valid price';
  }
  if (double.parse(value) < 0) {
    return 'Please enter a valid price';
  }
  return null;
}

class ResItemsPage extends StatefulWidget {
  const ResItemsPage({super.key});

  @override
  State<ResItemsPage> createState() => _ResItemsPageState();
}

class _ResItemsPageState extends State<ResItemsPage> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: const Center(
            child: Text('Items'),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: appGreen,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddItemPage()));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final itemNameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  Map<String, int> addOns = {};
  String selectedCategory = '0';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  late File? imageFile = File('');
  @override
  void dispose() {
    itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Item Name',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'ubuntu-bold'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Item name text field
                    CustomTextField(
                        labelText: '',
                        hintText: '',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter item name';
                          }
                          return null;
                        },
                        emailController: itemNameController,
                        boxH: 100,
                        primaryColor: appGreen),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Item Description',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'ubuntu-bold'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: descController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      maxLines: 3,
                      maxLength: 80,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: appGreen),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appGreen),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appGreen),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Item Price',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'ubuntu-bold'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      inputType: TextInputType.number,
                      emailController: priceController,
                      boxH: 100,
                      primaryColor: appGreen,
                      hintText: '',
                      labelText: '',
                      validator: priceValidator,
                    ),
                    const SizedBox(height: 20),
                    //Item image
                    Row(
                      children: [
                        const Text(
                          'Item image',
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'ubuntu-bold'),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              picker
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) {
                                setState(() {
                                  imageFile = File(value!.path);
                                });
                              });
                            },
                            icon: const Icon(Icons.upload))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: imageFile!.path.isEmpty
                          ? const Center(
                              child: Text('No image selected'),
                            )
                          : Image.file(imageFile!),
                    ),
                    const SizedBox(height: 20),
                    //Category select Dropdown
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'ubuntu-bold'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        value: selectedCategory,
                        items: List.generate(
                            100,
                            (index) => DropdownMenuItem(
                                  value: index.toString(),
                                  child: Text('Category $index'),
                                )),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value.toString();
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Add ons',
                                style: TextStyle(
                                    fontFamily: 'ubuntu-bold', fontSize: 20),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  final key = GlobalKey<FormState>();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final nameController =
                                            TextEditingController();
                                        final addOnPriceController =
                                            TextEditingController();
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: const Text('Create Add on'),
                                          content: Form(
                                              key: key,
                                              child: SizedBox(
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      validator: (value) => value!
                                                              .isEmpty
                                                          ? 'Please enter add on name'
                                                          : null,
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Add on name'),
                                                    ),
                                                    TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: priceValidator,
                                                      controller:
                                                          addOnPriceController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Add on Price'),
                                                    ),
                                                  ],
                                                ),
                                              )),
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
                                                if (key.currentState!
                                                    .validate()) {
                                                  addOns[nameController.text] =
                                                      int.parse(
                                                          addOnPriceController
                                                              .text);
                                                  Navigator.of(context).pop();
                                                }
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
                              itemCount: max(addOns.length, 1),
                              itemBuilder: (context, index) {
                                return addOns.isEmpty
                                    ? const SizedBox(
                                        height: 300,
                                        child:
                                            Center(child: Text('No Add ons!')))
                                    : Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        elevation: 5,
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          leading: SizedBox(
                                            width: 20,
                                            child: IconButton(
                                              iconSize: 20,
                                              onPressed: () {
                                                final key =
                                                    GlobalKey<FormState>();
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      final nameController =
                                                          TextEditingController();
                                                      final addOnPriceController =
                                                          TextEditingController();
                                                      nameController.text =
                                                          addOns.keys
                                                              .toList()[index];
                                                      addOnPriceController
                                                              .text =
                                                          addOns.values
                                                              .toList()[index]
                                                              .toString();
                                                      return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        title: const Text(
                                                            'Create Add on'),
                                                        content: Form(
                                                            key: key,
                                                            child: SizedBox(
                                                              height: 150,
                                                              child: Column(
                                                                children: [
                                                                  TextFormField(
                                                                    validator: (value) => value!
                                                                            .isEmpty
                                                                        ? 'Please enter add on name'
                                                                        : null,
                                                                    controller:
                                                                        nameController,
                                                                    decoration: const InputDecoration(
                                                                        hintText:
                                                                            'Add on name'),
                                                                  ),
                                                                  TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    validator:
                                                                        priceValidator,
                                                                    controller:
                                                                        addOnPriceController,
                                                                    decoration: const InputDecoration(
                                                                        hintText:
                                                                            'Add on Price'),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                                'CANCEL'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                                'EDIT'),
                                                            onPressed:
                                                                () async {
                                                              if (key
                                                                  .currentState!
                                                                  .validate()) {
                                                                addOns[nameController
                                                                        .text] =
                                                                    int.parse(
                                                                        addOnPriceController
                                                                            .text);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
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
                                          title: Text(
                                            '${addOns.keys.toList()[index]}\nRs: ${addOns.values.toList()[index]}',
                                          ),
                                          trailing: IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                addOns.remove(addOns.keys
                                                    .toList()[index]);
                                              });
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
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                        },
                        child: isLoading
                            ? const CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.white,
                              )
                            : const Text('Save')),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
