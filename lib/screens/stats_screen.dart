import 'package:flutter/material.dart';
import 'package:weight_tracker/components/height_card.dart';
import 'package:weight_tracker/components/motivation_card.dart';
import 'package:weight_tracker/components/sex_card.dart';
import 'package:weight_tracker/screens/account_screen.dart';
import 'package:weight_tracker/screens/home_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';
import 'package:weight_tracker/components/weight_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  static const String id = 'stats_screen';

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<Widget> pages = [
    Text("Home"),
    Text("Stats"),
    Text("Account"),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print(_selectedIndex);

      if (_selectedIndex == 0) {
        Navigator.pushNamed(context, HomeScreen.id);
      } else if (_selectedIndex == 1) {
        Navigator.pushNamed(context, StatsScreen.id);
      } else {
        Navigator.pushNamed(context, AccountScreen.id);
      }
    });
  }

  Color getSelectedItemColor() {
    return const Color.fromRGBO(27, 195, 184, 1);
  }

  @override
  void initState() {
    super.initState();

    _selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: kBackgrounGradientColor,
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: const [
                      WeightCard(),
                      HeightCard(),
                      HeightCard(),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kBackgroundColor,
          elevation: 10.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.data_usage),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: getSelectedItemColor(),
          onTap: _onItemTapped,
        ),
      ),
    );
    ;
  }
}
