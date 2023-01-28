import 'package:flutter/material.dart';

// Colors
// rgb(29,56,58)
// rgb(50,168,180)
// rgb(76,39,89)
// rgb(50,32,70)
// rgb(27,195,184)
const kBackgroundColor = Color.fromRGBO(16, 10, 30, 1);
const kBackgroundColorLight = Color.fromARGB(255, 30, 19, 56);
const kMotivationCardColor = Color.fromRGBO(21, 28, 39, 1);
const kFontColor = Colors.white;
const kMotivationIconColor = Color.fromRGBO(180, 79, 143, 1);
const kButtomColor = Color.fromRGBO(27, 195, 184, 0.3);

const kBackgrounGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kBackgroundColor,
    kBackgroundColorLight,
  ],
);
