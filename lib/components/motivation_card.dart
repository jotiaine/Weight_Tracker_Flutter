import 'package:flutter/material.dart';
import 'package:weight_tracker/utilities/constants.dart';

String? _motivationText;

class MotivationCard extends StatefulWidget {
  const MotivationCard({super.key});

  @override
  State<MotivationCard> createState() => _MotivationCardState();
}

class _MotivationCardState extends State<MotivationCard> {
  // Method to get the data from the API
  // void getData() async {
  //   try {
  //     var data = await MotivationData().getMotivationData();
  //     setState(() {
  //       _motivationText = data;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // get the data from the API
    setState(() {
      _motivationText = 'Motivation text will be here';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20.0),
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
                  '"$_motivationText."',
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
