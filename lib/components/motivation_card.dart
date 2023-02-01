import 'package:flutter/material.dart';
import 'package:weight_tracker/network/motivation_data.dart';
import 'package:weight_tracker/utilities/constants.dart';

class MotivationCard extends StatefulWidget {
  const MotivationCard({super.key});

  @override
  State<MotivationCard> createState() => _MotivationCardState();
}

class _MotivationCardState extends State<MotivationCard> {
  late MotivationData motivationData;
  late String _motivationText;
  late String _motivationTextAuthor;

  void setupMotivationData() async {
    try {
      motivationData = MotivationData();
      await motivationData.getMotivationData();

      setState(() {
        _motivationText = motivationData.motivationText;
        _motivationTextAuthor = motivationData.motivationTextAuthor;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _motivationText = '';
    _motivationTextAuthor = '';

    setupMotivationData();
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
                    'Motivation',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(27, 195, 184, 0.5),
                    ),
                  ),
                ),
                const Icon(
                  Icons.favorite,
                  color: kMotivationIconColor,
                  size: 36.0,
                  semanticLabel: 'Text to motivate',
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  _motivationText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21.0,
                    color: kFontColor,
                  ),
                ),
                Text(
                  '- $_motivationTextAuthor',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21.0,
                    color: kFontColor,
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
