import 'package:flutter/material.dart';

// Colors
// rgb(29,56,58) in hex  #1d383a
// rgb(50,168,180) in hex  #32a8b4
// rgb(76,39,89) in hex  #4c2759
// rgb(50,32,70) in hex  #322046
//  rgb(27,195,184) in hex  #1bc3b8
// 64, 196, 255, 1 to hex #40c4ff
const kBackgroundColor = Color.fromRGBO(16, 10, 30, 1);
const kBackgroundColorLight = Color.fromARGB(255, 30, 19, 56);
const kMotivationCardColor = Color.fromRGBO(21, 28, 39, 1);
const kFontColor = Colors.white;
const kMotivationIconColor = Color.fromRGBO(180, 79, 143, 1);
const kButtonColor = Color.fromARGB(255, 0, 49, 92);
const kInputButtonColor = Color.fromRGBO(50, 32, 70, 1);
const kInputButtonColorPressed = Color.fromARGB(255, 0, 80, 74);

const kBackgrounGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kBackgroundColor,
    kBackgroundColorLight,
  ],
);
