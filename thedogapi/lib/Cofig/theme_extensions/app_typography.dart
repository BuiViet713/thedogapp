import 'package:flutter/material.dart';

@immutable
class DogTypography extends ThemeExtension<DogTypography> {
  const DogTypography({
    required this.large,
    required this.medium,
    required this.small,
  });

  final TextStyle? large;

  final TextStyle? medium;

  final TextStyle? small;

  @override
  DogTypography copyWith({
    TextStyle? large,
    TextStyle? medium,
    TextStyle? small,
  }) {
    return DogTypography(
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
    );
  }

  @override
  DogTypography lerp(DogTypography? other, double t) {
    if (other is! DogTypography) {
      return this;
    }
    return DogTypography(
      large: TextStyle.lerp(large, other.large, t),
      medium: TextStyle.lerp(medium, other.medium, t),
      small: TextStyle.lerp(small, other.small, t),
    );
  }
}
