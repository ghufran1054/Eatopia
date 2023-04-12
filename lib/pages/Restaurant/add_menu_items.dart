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

class add_menu_items extends StatelessWidget {
  const add_menu_items({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Menu Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          //key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                //onSaved: (newValue) => _name = newValue!,
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
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
              SizedBox(height: 32),
              ElevatedButton(
                //onPressed: _submitForm,
                onPressed: () {},
                child: Text('Add Menu Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
