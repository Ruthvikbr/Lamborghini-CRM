import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamborghini/screens/components/custom_button.dart';
import 'package:lamborghini/screens/components/text_component.dart';
import 'package:lamborghini/services/constants/strings.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: _buildContents(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/registration-background.png"),
        fit: BoxFit.cover,
      )),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 122,
              height: 145,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextComponent(
                  text: Strings.signUpHeader,
                  textStyle: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildFormItem(
                  Strings.mobileLabel,
                  TextInputType.number,
                  false,
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildFormItem(
                  Strings.passwordLabel,
                  TextInputType.text,
                  true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  child: TextComponent(
                    text: Strings.signUpText,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.white,
                  borderRadius: 8,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextComponent(
                  text: Strings.existingMember,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => _navigateToSignInPage(context),
                  child: TextComponent(
                    text: Strings.existingAccount,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFormItem(
      String label, TextInputType textInputType, bool obscureText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          labelText: label,
          labelStyle: GoogleFonts.notoSans(
            textStyle: const TextStyle(color: Colors.black),
          ),
          border: InputBorder.none,
        ),
        keyboardType: textInputType,
        cursorColor: Colors.black,
        obscureText: obscureText,
        textInputAction:
            obscureText ? TextInputAction.done : TextInputAction.next,
      ),
    );
  }

  void _navigateToSignInPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
