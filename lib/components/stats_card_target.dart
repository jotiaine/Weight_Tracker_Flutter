import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/utilities/constants.dart';

class StatsCardTarget extends StatefulWidget {
  const StatsCardTarget({super.key});

  @override
  State<StatsCardTarget> createState() => _StatsCardTargetState();
}

class _StatsCardTargetState extends State<StatsCardTarget> {
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
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Text(
                    'Target',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(27, 195, 184, 0.5),
                    ),
                  ),
                ),
                const Icon(
                  Icons.task_alt,
                  color: kMotivationIconColor,
                  size: 36.0,
                  semanticLabel: 'Task icon',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                dataHandler.targetWeightStreamBuilder,
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Great',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: kFontColor,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
