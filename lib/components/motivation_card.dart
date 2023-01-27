import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weight_tracker/network/motivation_data.dart';
import 'package:weight_tracker/utilities/constants.dart';

String _motivationText = 'Loading...';
String _motivationTextAuthor = 'Unknown';

class MotivationCard extends StatefulWidget {
  const MotivationCard({super.key});

  @override
  State<MotivationCard> createState() => _MotivationCardState();
}

class _MotivationCardState extends State<MotivationCard> {
  @override
  void initState() {
    super.initState();

    var data = MotivationData().getMotivationData();

    // handle the response
    data.then((value) {
      var decodedData = jsonDecode(value);
      print(decodedData);
      print(decodedData['author']);
      print(decodedData['text']);

      String author = decodedData['author'];
      String text = decodedData['text'];

      // check if the author is null
      if (text == '') {
        text = 'Unknown';
      }

      setState(() {
        _motivationText = text;
        _motivationTextAuthor = author;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30.0,
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
                      fontSize: 18.0,
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
                  '$_motivationText',
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
