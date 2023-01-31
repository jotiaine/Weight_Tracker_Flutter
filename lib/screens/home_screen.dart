import 'package:flutter/material.dart';
import 'package:weight_tracker/components/height_card.dart';
import 'package:weight_tracker/components/motivation_card.dart';
import 'package:weight_tracker/components/gender_card.dart';
import 'package:weight_tracker/components/weight_target_card.dart';
import 'package:weight_tracker/screens/account_screen.dart';
import 'package:weight_tracker/screens/stats_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';
import 'package:weight_tracker/components/weight_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

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

    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: kBackgrounGradientColor,
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      MotivationCard(),
                      MotivationCard(),
                      MotivationCard(),
                      MotivationCard(),
                      MotivationCard(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: const [
                      GenderCard(),
                      WeightCard(),
                      HeightCard(),
                      WeightTargetCard(),
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
  }
}
