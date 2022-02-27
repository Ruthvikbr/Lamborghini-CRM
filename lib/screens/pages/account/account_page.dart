import 'package:flutter/material.dart';
import 'package:lamborghini/screens/components/custom_button.dart';
import 'package:lamborghini/screens/components/show_alert_dialog.dart';
import 'package:lamborghini/screens/pages/landing_page.dart';
import 'package:lamborghini/services/network/auth.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);


    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: CustomButton(
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              color: Colors.amber,
              borderRadius: 8.0,
              onPressed: () => _confirmSignOut(context),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: "Logout",
        content: "Are you sure you want to logout?",
        defaultActionText: "Confirm",
        cancelActionText: "Cancel");
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  void _signOut(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.logout();
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => const LandingPage(isLoggedIn: false,)),
    ModalRoute.withName('/')
    );

  }

}
