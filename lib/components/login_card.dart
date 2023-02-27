import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/screens/home_screen.dart';
import 'package:weight_tracker/screens/registration_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';

import '../screens/login_screen.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  late DataHandler _dataHandler;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  late String _email;
  late String _password;
  bool _isLoading = false;

  void clearText() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kMotivationCardColor,
          title: const Text('Something went wrong'),
          content:
              const Text('Incorrect password or email, try again or register.'),
          actions: [
            TextButton(
              onPressed: () {
                clearText();

                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void goToHomeScreen() {
    Navigator.pushNamed(context, HomeScreen.id);
  }

  @override
  void initState() {
    super.initState();

    _dataHandler = DataHandler();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 30.0,
              right: 30.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.track_changes,
                  size: 50.0,
                  color: Color.fromRGBO(64, 196, 255, 1),
                ),
                const Text(
                  'Weightsteps',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Take the first and the rest will follow',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextField(
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    try {
                      _email = value;
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14.0),
                TextField(
                  controller: _passwordTextController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    try {
                      _password = value;
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    try {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                Material(
                  elevation: 5.0,
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    // Within the `FirstRoute` widget
                    onPressed: () async {
                      try {
                        setState(() {
                          // This is to show the progress indicator
                          _isLoading = true;
                        });

                        // Sign in the user to the database, if successful, navigate to the home screen
                        bool isLoggedIn = await _dataHandler.signIn(
                          email: _email,
                          password: _password,
                        );

                        isLoggedIn ? goToHomeScreen() : showErrorDialog();

                        clearText();

                        setState(() {
                          // This is to hide the progress indicator
                          _isLoading = false;
                        });
                      } catch (e) {
                        // ignore: avoid_print
                        print(e);

                        showErrorDialog();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
