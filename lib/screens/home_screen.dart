import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weight_tracker/components/motivation_card.dart';
import 'package:weight_tracker/network/motivation_data.dart';
import 'package:weight_tracker/utilities/constants.dart';
import 'package:weight_tracker/components/input_card.dart';

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
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kBackgroundColor,
              kBackgroundColorLight,
            ],
          ),
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListView(
          children: const [
            MotivationCard(),
            InputCard(),
            InputCard(),
            InputCard(),
            InputCard(),
            InputCard(),
          ],
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
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(27, 195, 184, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
