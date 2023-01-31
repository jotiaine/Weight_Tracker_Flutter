import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/utilities/constants.dart';

class StatsCardBMI extends StatefulWidget {
  const StatsCardBMI({super.key});

  @override
  State<StatsCardBMI> createState() => _StatsCardBMIState();
}

class _StatsCardBMIState extends State<StatsCardBMI> {
  late DataHandler dataHandler;

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
          width: 300.0,
          margin: const EdgeInsets.only(
            top: 10.0,
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
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Text(
                    'BMI',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(27, 195, 184, 0.5),
                    ),
                  ),
                ),
                Icon(
                  Icons.numbers_sharp,
                  color: kMotivationIconColor,
                  size: 36.0,
                  semanticLabel: 'Text to motivate',
                ),
                SizedBox(
                  height: 10.0,
                ),
                dataHandler.calculateBMIStreamBuilder,
                SizedBox(
                  height: 10.0,
                ),
                dataHandler.getBMIResultStreamBuilder,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
