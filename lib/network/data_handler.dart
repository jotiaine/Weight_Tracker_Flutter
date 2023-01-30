import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/utilities/constants.dart';

class DataHandler {
  final _firestore = FirebaseFirestore.instance;
  User? loggedInUser;
  final _auth = FirebaseAuth.instance;
  late final String _uid;
  get context => null;

  // Sign in the user with email and password
  Future<bool> signIn({required email, required password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        // checks if user exists and if password is correct
        email: email,
        password: password,
      );

      if (user != null) {
        print(user);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Fetch the current logined user
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        _uid = loggedInUser!.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  // Add a new user to the firebase database
  Future<bool> addUser({
    required String email,
    required String password,
  }) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (newUser != null) {
        print(newUser);
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Adding a new weight to the firebase database
  void addWeight({required fieldTextController, required weight}) async {
    try {
      if (fieldTextController.text.isNotEmpty ||
          fieldTextController.text != '') {
        // round weight to 2 decimal place
        String weightStr = weight!.toStringAsFixed(1);
        weight = double.parse(weightStr);

        getCurrentUser();
      } else {
        // inform user to enter a weight with info dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: kMotivationCardColor,
              title: const Text('Please enter a weight'),
              content: const Text('You have to enter a weight to track it.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        if (weight == null) {
          return;
        }
      }

      await _firestore.collection('measurements').add({
        'weight': weight,
        'uid': _uid,
      });
    } catch (e) {
      print(e);
    }
  }

  // Adding a new height to the firebase database
  void addHeight({required fieldTextController, required height}) async {
    try {
      if (fieldTextController.text.isNotEmpty ||
          fieldTextController.text != '') {
        // round weight to 2 decimal place
        String weightStr = height.toStringAsFixed(1);
        height = double.parse(weightStr);

        getCurrentUser();
      } else {
        // inform user to enter a weight with info dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: kMotivationCardColor,
              title: const Text('Please enter a height'),
              content: const Text('You have to enter a height to track it.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        if (height == null) {
          return;
        }
      }

      await _firestore.collection('enums').add({
        'height': height,
        'sex': null,
        'target': null,
        'uid': _uid,
      });
    } catch (e) {
      print(e);
    }
  }

  // Adding a new target weight to the firebase database
  void addWeightTarget(
      {required fieldTextController, required weightTarget}) async {
    try {
      if (fieldTextController.text.isNotEmpty ||
          fieldTextController.text != '') {
        // round weight to 2 decimal place
        String weightStr = weightTarget!.toStringAsFixed(1);
        weightTarget = double.parse(weightStr);

        getCurrentUser();
      } else {
        // inform user to enter a weight with info dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: kMotivationCardColor,
              title: const Text('Please enter a target weight'),
              content:
                  const Text('You have to enter a target weight to track it.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        if (weightTarget == null) {
          return;
        }
      }

      await _firestore.collection('enums').add({
        'height': null,
        'sex': null,
        'target': weightTarget,
        'uid': _uid,
      });
    } catch (e) {
      print(e);
    }
  }

  // Fetch the measurements from the firebase database
  Future getMeasurements() async {
    try {
      getCurrentUser();
      return _firestore.collection('measurements');
    } catch (e) {
      print(e);
    }
  }

  // Log out the current user
  Future<bool> logOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
