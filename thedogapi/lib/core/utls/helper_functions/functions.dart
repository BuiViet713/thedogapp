import 'package:flutter/material.dart';

//remove keyboard
void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

//spacing
Widget addVerticalSpacing(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpacing(double width) {
  return SizedBox(
    width: width,
  );
}
