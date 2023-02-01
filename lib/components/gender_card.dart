import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/utilities/constants.dart';

class GenderCard extends StatefulWidget {
  const GenderCard({super.key});

  @override
  State<GenderCard> createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  late DataHandler _dataHandler;
  late String _fetchedGender;
  late bool _isMale;

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kMotivationCardColor,
          title: const Text('Something went wrong'),
          content: const Text('We are doing our best to fix the problem.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future getUserGender() async {
    return await _dataHandler.getUserGender();
  }

  void setGender() {
    getUserGender().then((value) {
      _fetchedGender = value;
    }).then((value) {
      setState(() {
        if (_fetchedGender == 'FEMALE') {
          _isMale = false;
        } else if (_fetchedGender == 'MALE') {
          _isMale = true;
        } else {
          _isMale = true;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _dataHandler = DataHandler();
    _isMale = true;
    _fetchedGender = '';
    setGender();
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
                  'Gender',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromRGBO(27, 195, 184, 0.5),
                  ),
                ),
                Icon(
                  _isMale ? Icons.male : Icons.female,
                  color: kMotivationIconColor,
                  size: 50.0,
                  semanticLabel: 'Gender',
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
                    color:
                        _isMale ? kInputButtonColorPressed : kInputButtonColor,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        try {
                          if (_dataHandler != null) {
                            _dataHandler
                                .updateGender(gender: 'MALE')
                                .then((value) {
                              // setState(() {
                              setGender();
                              // });
                            });
                          } else {
                            showErrorDialog();
                          }
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                          showErrorDialog();
                        }
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
                    color:
                        !_isMale ? kInputButtonColorPressed : kInputButtonColor,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        try {
                          _dataHandler.updateGender(gender: 'FEMALE').then(
                            (value) {
                              // setState(() {
                              setGender();
                              // });
                            },
                          );
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                          showErrorDialog();
                        }
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
