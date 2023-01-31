import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/utilities/constants.dart';

class GenderCard extends StatefulWidget {
  const GenderCard({super.key});

  @override
  State<GenderCard> createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  late DataHandler dataHandler;
  late bool _isMale;

  @override
  void initState() {
    super.initState();

    dataHandler = DataHandler();

    _isMale = true;
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
                        setState(() {
                          _isMale = true;
                        });

                        dataHandler.updateGender(gender: 'MALE');
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
                        setState(() {
                          _isMale = false;
                        });

                        dataHandler.updateGender(gender: 'FEMALE');
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
