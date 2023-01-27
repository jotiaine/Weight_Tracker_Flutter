import 'package:flutter/material.dart';
import 'package:weight_tracker/utilities/constants.dart';

class InputCard extends StatefulWidget {
  const InputCard({super.key});

  @override
  State<InputCard> createState() => InputCardState();
}

class InputCardState extends State<InputCard> {
  final fieldText = TextEditingController();

  int _weight = 80;

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  color: kMotivationIconColor,
                  size: 24.0,
                  semanticLabel: 'Text to motivate',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 0.0,
                  ),
                  child: TextField(
                    onTap: clearText,
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
                      setState(() {
                        _weight = int.parse(value);
                        print(_weight);
                      });
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
                      onPressed: () {
                        setState(() {
                          print('Save button pressed');
                        });
                      },
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 16.0,
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
