import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextComponent extends StatelessWidget {
  const TextComponent({
    Key? key,
    required this.text,
    required this.textStyle,
    this.textAlign,
  }) : super(key: key);
  final String text;
  final TextStyle textStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        textStyle: textStyle,
      ),
      textAlign: textAlign,
    );
  }
}
