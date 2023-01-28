import 'package:flutter/material.dart';
import 'package:weight_tracker/components/registration_card.dart';
import 'package:weight_tracker/utilities/constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: kBackgrounGradientColor,
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const RegistrationCard(),
        ),
      ),
    );
  }
}
