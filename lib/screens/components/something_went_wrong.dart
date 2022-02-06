import 'package:flutter/material.dart';

class SomethingWentWrongPage extends StatelessWidget {
  const SomethingWentWrongPage({
    Key? key,
    this.message = "Unable to retrieve the data at this moment",
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/something-went-wrong.jpg",
            width: 300,
            height: 200,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
