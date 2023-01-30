import 'package:flutter/material.dart';
import 'package:weight_tracker/network/data_handler.dart';
import 'package:weight_tracker/screens/login_screen.dart';
import 'package:weight_tracker/utilities/constants.dart';

class AccountCard extends StatefulWidget {
  const AccountCard({super.key});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  late DataHandler dataHandler;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    dataHandler = DataHandler();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
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
                Material(
                  elevation: 5.0,
                  color: kButtonColor,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    // Within the `FirstRoute` widget
                    onPressed: () async {
                      setState(() {
                        // This is to show the progress indicator
                        _isLoading = true;
                      });

                      await dataHandler.logOut()
                          ? Navigator.pushNamed(context, LoginScreen.id)
                          : null;

                      setState(() {
                        // This is to show the progress indicator
                        _isLoading = false;
                      });
                    },
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          );
  }
}
