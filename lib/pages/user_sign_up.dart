import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

////IN FIRST PAGE WE WILL GET THE EMAIL AND PASSWORD AND VERIFY IF THE USER EXISTS OR NOT
class UserSignUpPageOne extends StatefulWidget {
  const UserSignUpPageOne({super.key});

  @override
  State<UserSignUpPageOne> createState() => _UserSignUpPageOneState();
}

class _UserSignUpPageOneState extends State<UserSignUpPageOne> {
  //This _formKey will help us validate the inputs (check whether the user has entered the correct input or not)
  final _formKey = GlobalKey<FormState>();
  final Color _primaryColor = Color.fromARGB(255, 45, 94, 255);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  double boxEmailH = 50;
  double boxPassH = 50;
  Icon passIcon = const Icon(
    Icons.visibility,
    size: 20,
    color: Color.fromARGB(255, 87, 126, 255),
  );
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Image(image: AssetImage('images/logo.png'), height: 80),
            //SizedBox(width: 10),
            Text('EATOPIA',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))
          ])),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                color: _primaryColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    //EMAIL TEXT FIELD
                    TextFormField(
                      controller: emailController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      cursorColor: Colors.grey[600],
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        constraints:
                            BoxConstraints(maxHeight: boxEmailH, maxWidth: 400),
                        label: const Text('EMAIL'),
                        prefixIcon: Icon(
                          Icons.email,
                          color: _primaryColor,
                          size: 20,
                        ),
                        floatingLabelStyle:
                            TextStyle(color: _primaryColor, fontSize: 15),
                        labelStyle:
                            TextStyle(color: _primaryColor, fontSize: 10),
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _primaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _primaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: _primaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          boxEmailH = 70;
                          return 'Please enter your email';
                        } else if (!EmailValidator.validate(value)) {
                          boxEmailH = 70;
                          return 'Please enter a valid email';
                        }
                        boxEmailH = 50;
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    //PASSWORD TEXT FIELD
                    TextFormField(
                      controller: passwordController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                                if (_isObscure) {
                                  passIcon = Icon(
                                    Icons.visibility,
                                    size: 20,
                                    color: _primaryColor,
                                  );
                                } else {
                                  passIcon = Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                    color: _primaryColor,
                                  );
                                }
                              });
                            },
                            icon: passIcon,
                            iconSize: 20,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          constraints: BoxConstraints(
                              maxHeight: boxPassH, maxWidth: 400),
                          label: const Text('PASSWORD'),
                          floatingLabelStyle:
                              TextStyle(color: _primaryColor, fontSize: 15),
                          prefixIcon: Icon(Icons.password,
                              color: _primaryColor, size: 20),
                          labelStyle:
                              TextStyle(color: _primaryColor, fontSize: 10),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(fontSize: 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: _primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          boxPassH = 70;
                          return 'Password can\'t be empty';
                        } else if (value.length < 6) {
                          boxPassH = 70;
                          return 'Password must be at least 6 characters';
                        }
                        boxPassH = 50;
                        return null;
                      },
                    ),
                    const SizedBox(height: 20)
                  ],
                )),
            //NEXT SCREEN BUTTON
            //TODO: ADD VALIDATION in ON PRESSED FIRST THEN NAVIGATE TO NEXT SCREEN
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(_primaryColor),
                  fixedSize: MaterialStateProperty.all<Size>(Size(
                      MediaQuery.of(context).size.width / 3,
                      MediaQuery.of(context).size.height / 18)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                Navigator.pushNamed(context, '/UserSignUpPageTwo', arguments: {
                  'email': emailController.text,
                  'password': passwordController.text,
                });
              },
              child: const Text('Continue'),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(_primaryColor),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/UserSignIn');
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//USER SIGN - UP PAGE TWO TAKE INPUT FOR USERNAME, PHONE NUMBER AND ADDRESS AND THEN THE SIGN UP IS COMPLETE

class UserSignUpPageTwo extends StatefulWidget {
  const UserSignUpPageTwo({super.key});

  @override
  State<UserSignUpPageTwo> createState() => _UserSignUpPageTwoState();
}

class _UserSignUpPageTwoState extends State<UserSignUpPageTwo> {
  Map userData = {};
  final _formKey = GlobalKey<FormState>();
  final Color _primaryColor = Color.fromARGB(255, 45, 94, 255);
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  double boxUserH = 50;
  double boxPhoneH = 50;
  @override
  Widget build(BuildContext context) {
    //We got this data from first page of sign up
    userData = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            Image(image: AssetImage('images/logo.png'), height: 80),
            //SizedBox(width: 10),
            Text('EATOPIA',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))
          ])),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: _primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //USER NAME TEXT FIELD
                        TextFormField(
                          controller: userNameController,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          cursorColor: Colors.grey[600],
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            constraints: BoxConstraints(
                                maxHeight: boxUserH, maxWidth: 400),
                            label: const Text('USERNAME'),
                            prefixIcon: Icon(
                              Icons.person,
                              color: _primaryColor,
                              size: 20,
                            ),
                            floatingLabelStyle:
                                TextStyle(color: _primaryColor, fontSize: 15),
                            labelStyle:
                                TextStyle(color: _primaryColor, fontSize: 10),
                            hintText: 'Enter your username',
                            hintStyle: const TextStyle(fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              boxUserH = 70;
                              return 'Please enter your email';
                            }
                            boxUserH = 50;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        //Phone Number Text Field
                        TextFormField(
                          controller: phoneController,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          cursorColor: Colors.grey[600],
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            constraints: BoxConstraints(
                                maxHeight: boxUserH, maxWidth: 400),
                            label: const Text('PHONE NUMBER'),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: _primaryColor,
                              size: 20,
                            ),
                            floatingLabelStyle:
                                TextStyle(color: _primaryColor, fontSize: 15),
                            labelStyle:
                                TextStyle(color: _primaryColor, fontSize: 10),
                            hintText: 'Enter your phone number',
                            hintStyle: const TextStyle(fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              boxUserH = 70;
                              return 'Please enter valid phone number';
                            }
                            boxPhoneH = 50;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        //Address Text Field
                        TextFormField(
                          controller: addressController,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          cursorColor: Colors.grey[600],
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            constraints: BoxConstraints(
                                maxHeight: boxUserH, maxWidth: 400),
                            label: const Text('Address'),
                            prefixIcon: Icon(
                              Icons.home_filled,
                              color: _primaryColor,
                              size: 20,
                            ),
                            floatingLabelStyle:
                                TextStyle(color: _primaryColor, fontSize: 15),
                            labelStyle:
                                TextStyle(color: _primaryColor, fontSize: 10),
                            hintText: 'Enter your Address',
                            hintStyle: const TextStyle(fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: _primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              boxUserH = 70;
                              return 'Address Can\'t be empty';
                            }
                            boxPhoneH = 50;
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                //TODO: NOW USE FIREBASE TO SEND THIS DATA TO DATABASE
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(_primaryColor),
                      fixedSize: MaterialStateProperty.all<Size>(Size(
                          MediaQuery.of(context).size.width / 3,
                          MediaQuery.of(context).size.height / 18)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
