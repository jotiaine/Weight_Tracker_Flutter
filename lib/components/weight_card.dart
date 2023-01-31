import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/utilities/constants.dart';

class WeightCard extends StatefulWidget {
  const WeightCard({super.key});

  @override
  State<WeightCard> createState() => WeightCardState();
}

class WeightCardState extends State<WeightCard> {
  late DataHandler dataHandler;
  double? _weight;

  final fieldTextController = TextEditingController();

  void clearText() {
    fieldTextController.clear();
  }

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
                  Icons.monitor_weight,
                  color: kMotivationIconColor,
                  size: 50.0,
                  semanticLabel: 'Weight Icon',
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
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(50, 32, 70, 1), width: 3.5),
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
                      onPressed: () {
                        if (_weight! >= 45 && _weight! <= 300) {
                          dataHandler.addWeight(
                            weight: _weight,
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: kMotivationCardColor,
                                title: const Text('Please enter a height'),
                                content: const Text(
                                    'You have to enter a weight to track it.'),
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
                        }

                        clearText();
                      },
                      child: const Text(
                        'SAVE',
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
