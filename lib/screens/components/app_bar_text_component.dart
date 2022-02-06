import 'package:flutter/material.dart';
import 'package:lamborghini/screens/components/text_component.dart';

class AppBarTextComponent extends StatelessWidget {
  const AppBarTextComponent({Key? key,required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextComponent(
       text: text.toUpperCase(),
       textStyle: const TextStyle(
         color: Colors.white,
         fontSize: 18,
         fontWeight: FontWeight.bold,
       ),
       textAlign: TextAlign.left,
     );
  }
}
