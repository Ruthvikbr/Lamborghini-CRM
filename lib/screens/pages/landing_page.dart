import 'package:flutter/material.dart';
import 'package:lamborghini/screens/pages/sign_in.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignIn(),
    );
  }
}
