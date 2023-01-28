import 'package:flutter/material.dart';
import 'package:weight_tracker/utilities/constants.dart';
import 'package:weight_tracker/components/login_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: const LoginCard(),
        ),
      ),
    );
  }
}
