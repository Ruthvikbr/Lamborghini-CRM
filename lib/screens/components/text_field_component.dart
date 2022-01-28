import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lamborghini/model/account_request.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    Key? key,
    required this.label,
    required this.textInputType,
    required this.obscureText,
    this.accountRequest,
    required this.focusNode,
    required this.controller,
    required this.onEditingCompleted,
    required this.onChanged,
  }) : super(key: key);
  final String label;
  final TextInputType textInputType;
  final bool obscureText;
  final AccountRequest? accountRequest;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(AccountRequest?) onEditingCompleted;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          labelText: label,
          labelStyle: GoogleFonts.notoSans(
            textStyle: const TextStyle(color: Colors.black),
          ),
          enabled: !accountRequest!.loading,
          border: InputBorder.none,
        ),
        keyboardType: textInputType,
        cursorColor: Colors.black,
        obscureText: obscureText,
        focusNode: focusNode,
        textInputAction:
            obscureText ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () => onEditingCompleted(accountRequest),
        onChanged: onChanged,
      ),
    );
  }
}
