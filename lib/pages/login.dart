import 'package:eatopia/utilities/colours.dart';
import 'package:eatopia/utilities/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

////IN FIRST PAGE WE WILL GET THE EMAIL AND PASSWORD AND VERIFY IF THE USER EXISTS OR NOT
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //This _formKey will help us validate the inputs (check whether the user has entered the correct input or not)
  final _formKey = GlobalKey<FormState>();
  final Color _primaryColor = appGreen;
  final emailController = TextEditingController();
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Image(image: AssetImage('images/eatopia.png'), height: 50),
            SizedBox(width: 10),
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
            const Text(
              'Login',
              style: TextStyle(
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
                    CustomTextField(
                        icon: const Icon(
                          Icons.email,
                          color: Colors.black,
                          size: 20,
                        ),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        emailController: emailController,
                        boxH: 100,
                        primaryColor: _primaryColor),
                    const SizedBox(height: 20),
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
