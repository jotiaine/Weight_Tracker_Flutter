import 'package:flutter/material.dart';
import 'package:weight_tracker/components/motivation_card.dart';
import 'package:weight_tracker/utilities/constants.dart';
import 'package:weight_tracker/components/weight_input_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('asdasd');
    // get the data from the API
    // parse the JSON
    // update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: mounted,
        backgroundColor: kBackgroundColor,
        elevation: 20.0,
        title: const Text('Weight Tracker'),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          MotivationCard(),
          InputCard(),
          InputCard(),
          InputCard(),
          InputCard(),
          InputCard(),
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Text('Bottom'),
      // ),
    );
  }
}
