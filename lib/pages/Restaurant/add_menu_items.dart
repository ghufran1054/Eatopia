import 'package:flutter/material.dart';

class MenuItem {
  String name;
  String category;
  double price;

  MenuItem({required this.name, required this.category, required this.price});
}

// class AddMenuItemPage extends StatefulWidget {
//   const AddMenuItemPage({Key? key}) : super(key: key);

//   @override
//   _AddMenuItemPageState createState() => _AddMenuItemPageState();
// }
var items = [
  'Appetizer',
  'Main Course',
  'Dessert',
  'Beverages',
];
String dropdownvalue = 'Appetizer';

class add_menu_items extends StatelessWidget {
  const add_menu_items({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Menu Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          //key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                //onSaved: (newValue) => _name = newValue!,
              ),
              const SizedBox(height: 16),
              //DropdownButtonFormField(
              //decoration: InputDecoration(labelText: 'Category'),
              //value: _category,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please select a category';
              //   }
              //   return null;
              // },
              // items: _categories.map((category) {
              //   return DropdownMenuItem(
              //     value: category,
              //     child: Text(category),
              //   );
              // }).toList(),
              // onChanged: (newValue) => setState(() => _category = newValue as String),
              // onSaved: (newValue) => _category = newValue!,
              //),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                //onSaved: (newValue) => _price = double.parse(newValue!),
              ),
              const SizedBox(height: 40),
              const Text(
                "choose meal type:",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 5),
              DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                //onPressed: _submitForm,
                onPressed: () {},
                child: const Text('Upload Image'),
              ),
              const SizedBox(height: 7),
              ElevatedButton(
                //onPressed: _submitForm,
                onPressed: () {},
                child: const Text('Add Menu Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void setState(Null Function() param0) {}
