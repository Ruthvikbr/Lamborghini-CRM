import 'package:flutter/material.dart';
import 'package:lamborghini/screens/pages/landing_page.dart';
import 'package:lamborghini/services/constants/color_constants.dart';
import 'package:lamborghini/services/network/auth.dart';
import 'package:lamborghini/services/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await SharedPrefs.getBooleanSharedPreference("isLoggedIn");
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Lamborghini',
        theme: ThemeData(
          primarySwatch: Constants.materialBlackColor,
        ),
        home: LandingPage(
          isLoggedIn: isLoggedIn,
        ),
      ),
    );
  }
}
