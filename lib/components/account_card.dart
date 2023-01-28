import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/home_screen.dart';
import 'package:weight_tracker/screens/login_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';

class AccountCard extends StatefulWidget {
  const AccountCard({super.key});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              color: Colors.white,
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
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, RegistrationScreen.id);
          //   },
          //   child: const Text('Sign up'),
          // ),
          Material(
            elevation: 5.0,
            color: kButtomColor,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              // Within the `FirstRoute` widget
              onPressed: logOut,
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
