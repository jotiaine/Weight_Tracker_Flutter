import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/utilities/constants.dart';

class WeightTargetCard extends StatefulWidget {
  const WeightTargetCard({super.key});

  @override
  State<WeightTargetCard> createState() => WeightTargetCardState();
}

class WeightTargetCardState extends State<WeightTargetCard> {
  late DataHandler _dataHandler;
  late double _weightTarget;
  final _fieldTextController = TextEditingController();

  void clearText() {
    _fieldTextController.clear();
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kMotivationCardColor,
          title: const Text('Please enter a target weight'),
          content: const Text(
              'You have to enter a reasonable target weight to track it.'),
          actions: [
            TextButton(
              onPressed: () {
                clearText();

                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _dataHandler = DataHandler();

    setState(() {
      _weightTarget = 0.0;
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Clean up the controller when the widget is disposed.
    _fieldTextController.dispose();
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
                  'Target weight',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromRGBO(27, 195, 184, 0.5),
                  ),
                ),
                const Icon(
                  Icons.task_alt_outlined,
                  color: kMotivationIconColor,
                  size: 50.0,
                  semanticLabel: 'Task icon',
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
                    controller: _fieldTextController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Enter your target weight in kg',
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
                      try {
                        _weightTarget = double.parse(value);
                      } catch (e) {
                        // ignore: avoid_print
                        print(e);
                        showErrorDialog();
                      }
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
                        try {
                          if (_weightTarget >= 45 &&
                              _weightTarget <= 150 &&
                              _weightTarget != 0.0) {
                            _dataHandler
                                .updateWeightTarget(
                                  weightTarget: _weightTarget,
                                )
                                .then((value) => clearText());
                          } else {
                            showErrorDialog();
                          }
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);

                          showErrorDialog();
                        } finally {
                          clearText();
                          dispose();
                        }
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
