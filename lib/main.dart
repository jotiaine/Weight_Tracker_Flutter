import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/account_screen.dart';
import 'package:weight_tracker/screens/home_screen.dart';
import 'package:weight_tracker/screens/login_screen.dart';
import 'package:weight_tracker/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        AccountScreen.id: (context) => const AccountScreen(),
      },
    );
  }
}
