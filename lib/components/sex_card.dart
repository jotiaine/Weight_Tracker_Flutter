import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/utilities/constants.dart';

enum Gender { male, female }

class SexCard extends StatefulWidget {
  const SexCard({super.key});

  @override
  State<SexCard> createState() => _SexCardState();
}

class _SexCardState extends State<SexCard> {
  Gender? _selectedGender;
  late DataHandler dataHandler;

  // void getSex() {
  //   // change background to green

  //   // search enums collection for a document with the uid
  //   print(_firestore.collection('enums').snapshots().map((event) => null));

  //   // if has data
  // }

  @override
  void initState() {
    super.initState();

    dataHandler = DataHandler();
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
              // top: 10.0,
              bottom: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sex',
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
                    horizontal: 80.0,
                    vertical: 0.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    color: _selectedGender == Gender.male
                        ? kInputButtonColorPressed
                        : kInputButtonColor,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          _selectedGender = Gender.male;
                        });
                      },
                      child: const Text(
                        'MALE',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 80.0,
                    right: 80.0,
                    bottom: 0.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    color: _selectedGender == Gender.female
                        ? kInputButtonColorPressed
                        : kInputButtonColor,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          _selectedGender = Gender.female;
                        });
                      },
                      child: const Text(
                        'FEMALE',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
