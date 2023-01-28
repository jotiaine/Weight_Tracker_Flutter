import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/utilities/constants.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class InputCard extends StatefulWidget {
  const InputCard({super.key});

  @override
  State<InputCard> createState() => InputCardState();
}

class InputCardState extends State<InputCard> {
  final _auth = FirebaseAuth.instance;
  String? _uid;
  double? _weight = 80;

  final fieldTextController = TextEditingController();

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

  void clearText() {
    fieldTextController.clear();
  }

  void addWeight() {
    _firestore.collection('measurements').add({
      'weight': _weight,
      'uid': _uid,
    });
    fieldTextController.clear();
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250.0,
          margin: const EdgeInsets.only(
            top: 15.0,
            left: 10.0,
            right: 10.0,
          ),
          decoration: BoxDecoration(
            color: kMotivationCardColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10.0,
              top: 10.0,
              bottom: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Weight',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromRGBO(27, 195, 184, 0.5),
                  ),
                ),
                const Icon(
                  Icons.favorite,
                  color: kMotivationIconColor,
                  size: 50.0,
                  semanticLabel: 'Text to motivate',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: TextField(
                    controller: fieldTextController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Enter your weight in kg',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(50, 32, 70, 1),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(50, 32, 70, 1), width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                    onChanged: (value) {
                      _weight = double.parse(value);
                    },
                  ),
                ),
                // Make a stylish elevated button
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 0.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    color: const Color.fromRGBO(50, 32, 70, 1),
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: addWeight,
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),

                // RawMaterialButton(
                //   elevation: 0.0,
                //   child: Icon(Icons),
                //   fillColor: Colors.red,
                //   shape: CircleBorder(),
                //   onPressed: () {
                //     print('asd');
                //   },
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
