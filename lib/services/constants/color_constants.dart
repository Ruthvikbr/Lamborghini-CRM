import 'package:flutter/material.dart';

class Constants {
  static Map<int, Color> get black => {
        50: const Color.fromRGBO(0, 0, 0, .1),
        100: const Color.fromRGBO(0, 0, 0, .2),
        200: const Color.fromRGBO(0, 0, 0, .3),
        300: const Color.fromRGBO(0, 0, 0, .4),
        400: const Color.fromRGBO(0, 0, 0, .5),
        500: const Color.fromRGBO(0, 0, 0, .6),
        600: const Color.fromRGBO(0, 0, 0, .7),
        700: const Color.fromRGBO(0, 0, 0, .8),
        800: const Color.fromRGBO(0, 0, 0, .9),
        900: const Color.fromRGBO(0, 0, 0, 1),
      };

  static Map<int, Color> get white => {
        50: const Color.fromRGBO(255, 255, 255, .1),
        100: const Color.fromRGBO(255, 255, 255, .2),
        200: const Color.fromRGBO(255, 255, 255, .3),
        300: const Color.fromRGBO(255, 255, 255, .4),
        400: const Color.fromRGBO(255, 255, 255, .5),
        500: const Color.fromRGBO(255, 255, 255, .6),
        600: const Color.fromRGBO(255, 255, 255, .7),
        700: const Color.fromRGBO(255, 255, 255, .8),
        800: const Color.fromRGBO(255, 255, 255, .9),
        900: const Color.fromRGBO(255, 255, 255, 1),
      };

  static MaterialColor materialBlackColor = MaterialColor(0xFF000000, black);
  static MaterialColor materialWhiteColor = MaterialColor(0xFFFFFFFF, white);

  static const greyScale = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ]);
}
