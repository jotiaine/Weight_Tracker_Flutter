import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/screens/login_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';

class RegistrationCard extends StatefulWidget {
  const RegistrationCard({super.key});

  @override
  State<RegistrationCard> createState() => _RegistrationCardState();
}

class _RegistrationCardState extends State<RegistrationCard> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  late DataHandler dataHandler;
  String? _email;
  String? _password;

  void clearTextfields() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void initState() {
    super.initState();

    dataHandler = DataHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50.0,
        left: 30.0,
        right: 30.0,
        bottom: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.track_changes,
            size: 50.0,
            color: Colors.lightBlueAccent,
          ),
          const Text(
            'Weightsteps',
            style: TextStyle(
              color: Colors.white,
              fontSize: 45.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Text(
            'Take the first and the rest will follow',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextField(
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              _email = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          TextField(
            obscureText: true,
            controller: _passwordTextController,
            textAlign: TextAlign.center,
            onChanged: (value) {
              _password = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter your password',
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlueAccent,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          Material(
            elevation: 5.0,
            color: kButtonColor,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 42.0,
              onPressed: () {
                dataHandler.addUser(email: _email!, password: _password!);

                Navigator.pushNamed(context, LoginScreen.id);
                clearTextfields();
              },
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
