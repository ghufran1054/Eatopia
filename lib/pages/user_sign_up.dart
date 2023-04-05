import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final Color _primaryColor = Color.fromARGB(255, 87, 126, 255);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  Icon passIcon = const Icon(
    Icons.visibility,
    size: 20,
    color: Color.fromARGB(255, 87, 126, 255),
  );
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Already have an account?'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _primaryColor,
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //EMAIL TEXT FIELD
            TextFormField(
              controller: emailController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              cursorColor: Colors.grey[600],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                constraints: const BoxConstraints(maxHeight: 50),
                label: const Text('EMAIL'),
                prefixIcon: Icon(
                  Icons.email,
                  color: _primaryColor,
                  size: 20,
                ),
                floatingLabelStyle:
                    TextStyle(color: _primaryColor, fontSize: 15),
                labelStyle: TextStyle(color: _primaryColor, fontSize: 10),
                hintText: 'Enter your email',
                hintStyle: const TextStyle(fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            //USERNAME TEXT FIELD
            TextFormField(
              controller: userNameController,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              cursorColor: Colors.grey[600],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                constraints: const BoxConstraints(maxHeight: 50),
                label: const Text('USERNAME'),
                floatingLabelStyle:
                    TextStyle(color: _primaryColor, fontSize: 15),
                prefixIcon: Icon(Icons.person, color: _primaryColor, size: 20),
                labelStyle: TextStyle(color: _primaryColor, fontSize: 10),
                hintText: 'Enter your username',
                hintStyle: const TextStyle(fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
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
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                constraints: const BoxConstraints(maxHeight: 50),
                label: const Text('PASSWORD'),
                floatingLabelStyle:
                    TextStyle(color: _primaryColor, fontSize: 15),
                prefixIcon:
                    Icon(Icons.password, color: _primaryColor, size: 20),
                labelStyle: TextStyle(color: _primaryColor, fontSize: 10),
                hintText: 'Enter your password',
                hintStyle: const TextStyle(fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
              onPressed: () {},
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
