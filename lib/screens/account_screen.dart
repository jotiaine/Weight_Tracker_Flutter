import 'package:flutter/material.dart';
import 'package:weight_tracker/components/account_card.dart';
import 'package:weight_tracker/screens/home_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  static const String id = 'account_screen';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Widget> pages = [
    Text("Home"),
    Text("Account"),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print(_selectedIndex);

      if (_selectedIndex == 0) {
        Navigator.pushNamed(context, HomeScreen.id);
      } else {
        Navigator.pushNamed(context, AccountScreen.id);
      }
    });
  }

  Color getSelectedItemColor() {
    if (_selectedIndex == 0) {
      return const Color.fromRGBO(27, 195, 184, 1);
    } else {
      return const Color.fromRGBO(27, 195, 184, 1);
    }
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
        backgroundColor: kBackgroundColor,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: kBackgrounGradientColor,
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const AccountCard(),
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
              icon: Icon(Icons.school),
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
