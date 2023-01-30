import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/screens/home_screen.dart';
import 'package:weight_tracker/screens/registration_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  late DataHandler dataHandler;
  User? loggedInUser;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  String? _email;
  String? _password;
  bool _isLoading = false;

  void clearTextfields() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void initState() {
    super.initState();

    dataHandler = DataHandler();
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
                  color: Colors.lightBlueAccent,
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
                    _email = value;
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
                    _password = value;
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
                    Navigator.pushNamed(context, RegistrationScreen.id);
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
                      setState(() {
                        // This is to show the progress indicator
                        _isLoading = true;
                      });

                      // Sign in the user to the database, if successful, navigate to the home screen
                      await dataHandler.signIn(
                        email: _email,
                        password: _password,
                      )
                          ? Navigator.pushNamed(context, HomeScreen.id)
                          : null;

                      clearTextfields();

                      setState(() {
                        // This is to hide the progress indicator
                        _isLoading = false;
                      });
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
