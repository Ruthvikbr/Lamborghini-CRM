import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.child,
    required this.color,
    required this.borderRadius,
    required this.onPressed,
    this.height = 50.0,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final double borderRadius;
  final VoidCallback? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.black87,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
