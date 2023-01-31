import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/utilities/constants.dart';

class DataHandler {
  final _firestore = FirebaseFirestore.instance;
  User? loggedInUser;
  final _auth = FirebaseAuth.instance;
  late final String _uid;
  double? _bmi;
  double? _height;
  double? _weight;
  double? _targetWeight;
  double? _toLoseWeight;

  // Sign in the user with email and password
  Future<bool> signIn({required email, required password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        // checks if user exists and if password is correct
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      // ignore: avoid_print
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
      // ignore: avoid_print
      print(e);
    }
  }

  // fetch the target weight from the database
  Stream<double> get targetWeightStream {
    try {
      getCurrentUser();

      return _firestore
          .collection('enums')
          .where('uid', isEqualTo: _uid)
          .snapshots()
          .map((event) {
        final targetWeight = event.docs[0].data()['target'];
        return targetWeight;
      }).asyncMap((targetWeight) async {
        final weightSnapshot = await _firestore
            .collection('measurements')
            .where('uid', isEqualTo: _uid)
            .orderBy('date', descending: true)
            .limit(1)
            .get();

        final weight = weightSnapshot.docs[0].data()['weight'];
        _targetWeight = targetWeight;
        _weight = weight;
        _toLoseWeight = _weight! - _targetWeight!;

        return _toLoseWeight!;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return const Stream.empty();
    }
  }

  // Add a new user to the firebase database
  Future<bool> addUser({
    required String email,
    required String password,
  }) async {
    try {
      // Create username and password
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      getCurrentUser();

      // Create an empty nums document
      await _firestore.collection('enums').add({
        'height': null,
        'gender': null,
        'target': null,
        'uid': _uid,
      });

      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  // Adding a new weight to the firebase database
  Future<void> addWeight({required double weight}) async {
    try {
      getCurrentUser();

      await _firestore.collection('measurements').add({
        'uid': _uid,
        'weight': weight,
        'date': DateTime.now(),
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // get _bmi
  double? get bmi => _bmi;

  // make calculateBMI method to a StreamBuilder
  Stream<double> get calculateBMIStream {
    try {
      getCurrentUser();

      return _firestore
          .collection('measurements')
          .where('uid', isEqualTo: _uid)
          .orderBy('date', descending: true)
          .limit(1)
          .snapshots()
          .map((event) {
        final weight = event.docs[0].data()['weight'];
        return weight;
      }).asyncMap((weight) async {
        final heightSnapshot = await _firestore
            .collection('enums')
            .where('uid', isEqualTo: _uid)
            .get();

        final height = heightSnapshot.docs[0].data()['height'];
        final bmi = weight / (height / 100 * height / 100);
        setBMI(bmi!);
        return bmi;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return const Stream.empty();
    }
  }

  // make streamBuilder for targetWeightStream
  StreamBuilder<double> get targetWeightStreamBuilder {
    try {
      return StreamBuilder<double>(
        stream: targetWeightStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!.toStringAsFixed(1),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21.0,
                color: kFontColor,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return StreamBuilder<double>(
        stream: const Stream.empty(),
        builder: (context, snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }

  // make streamBuilder for calculateBMIStream
  StreamBuilder<double> get calculateBMIStreamBuilder {
    try {
      return StreamBuilder<double>(
        stream: calculateBMIStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!.toStringAsFixed(1),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21.0,
                color: kFontColor,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return StreamBuilder<double>(
        stream: const Stream.empty(),
        builder: (context, snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }

  // make stream for getBMIResult
  Stream<String> get getBMIResultStream {
    try {
      return calculateBMIStream.map((bmi) {
        if (bmi < 18.5) {
          return 'Underweight';
        } else if (bmi >= 18.5 && bmi < 25) {
          return 'Normal';
        } else if (bmi >= 25 && bmi < 30) {
          return 'Overweight';
        } else {
          return 'Obese';
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return const Stream.empty();
    }
  }

  // make streamBuilder for getBMIResult
  StreamBuilder<Object> get getBMIResultStreamBuilder {
    try {
      return StreamBuilder<double>(
        stream: calculateBMIStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getBMIResult(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return StreamBuilder<String>(
        stream: const Stream.empty(),
        builder: (context, snapshot) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> bmiStatsBuilder() {
    return StreamBuilder(
      stream: _firestore
          .collection('measurements')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, streamSnapshot) {
        // If data is waiting show progress bar
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        var documents = streamSnapshot.data?.docs;

        // ignore: unnecessary_null_comparison
        if (documents != null) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: documents.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: kMotivationCardColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 100.0,
              margin: const EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      left: 10.0,
                    ),
                    child: Text(
                      'History',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromRGBO(27, 195, 184, 0.5),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.my_library_books_rounded,
                    color: kMotivationIconColor,
                    size: 26.0,
                    semanticLabel: 'Weight data icon',
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: Text(
                      documents[index]['weight'].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: kFontColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
      },
    );
  }

  // get _height
  double? get height => _height;

  // get _weight
  double? get weight => _weight;

  setBMI(double bmi) {
    _bmi = bmi;
  }

  // Calculate the bmi result
  String getBMIResult() {
    if (_bmi! > 30) {
      return 'Obese';
    } else if (_bmi! >= 25) {
      return 'Overweight';
    } else if (_bmi! > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  // Adding a new target weight to the firebase database
  Future updateWeightTarget({required double weightTarget}) async {
    try {
      getCurrentUser();

      // Updating weigh Target into the database
      final snapshot = await _firestore
          .collection('enums')
          .where('uid', isEqualTo: _uid)
          .get();

      final id = snapshot.docs[0].id;

      await _firestore.collection('enums').doc(id).update({
        'target': weightTarget,
      });

      return;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future updateHeight({required double height}) async {
    try {
      getCurrentUser();

      // Updating height in the database
      final snapshot = await _firestore
          .collection('enums')
          .where('uid', isEqualTo: _uid)
          .get();

      final id = snapshot.docs[0].id;

      await _firestore.collection('enums').doc(id).update({
        'height': height,
      });

      return;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future updateGender({required String gender}) async {
    try {
      // Set height 0.0 if not found
      getCurrentUser();

      // Updating height in the database
      final snapshot = await _firestore
          .collection('enums')
          .where('uid', isEqualTo: _uid)
          .get();

      final id = snapshot.docs[0].id;

      await _firestore.collection('enums').doc(id).update({
        'gender': gender,
      });

      return;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // Log out the current user
  Future<bool> logOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  // Setting target weight
  void setTargetWeight(double targetWeight) {
    _targetWeight = targetWeight;
  }

  // get toLoseWeight
  double? get toLoseWeight => _toLoseWeight;
}
