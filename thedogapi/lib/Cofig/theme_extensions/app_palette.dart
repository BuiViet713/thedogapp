import 'package:flutter/material.dart';

@immutable
class PawPallete extends ThemeExtension<PawPallete> {
  const PawPallete(
      {required this.textColor,
      required this.backgroundColor,
      this.primaryColor});

  // This is how we will determine the design color system to help us respect light and dark mode
  final Color? textColor;
  final Color? primaryColor;

  final Color? backgroundColor;

  @override
  PawPallete copyWith({
    Color? textColor,
    Color? primaryColor,
    Color? backgroundColor,
  }) {
    return PawPallete(
      textColor: textColor ?? this.textColor,
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  PawPallete lerp(PawPallete? other, double t) {
    if (other is! PawPallete) {
      return this;
    }
    return PawPallete(
        textColor: Color.lerp(textColor, other.textColor, t),
        backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t));
  }
}
