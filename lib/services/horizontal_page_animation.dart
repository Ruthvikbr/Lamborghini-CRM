import 'package:flutter/material.dart';

class HorizontalPageAnimation {
  static Route createRoute(Widget destination, Widget childCurrent) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeOut;

        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: childCurrent,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: child,
            ),
          ],
        );
      },
    );
  }
}
