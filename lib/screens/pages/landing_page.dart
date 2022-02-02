import 'package:flutter/material.dart';
import 'package:lamborghini/screens/pages/home_page.dart';
import 'package:lamborghini/screens/pages/auth/sign_in.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return const Scaffold(
        body: HomePage(),
      );
    } else {
      return Scaffold(
        body: SignIn.create(context),
      );
    }
  }
}
