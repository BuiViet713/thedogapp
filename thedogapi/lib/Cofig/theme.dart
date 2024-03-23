import 'package:flutter/material.dart';
import 'package:thedogapi/Cofig/colors.dart';
import 'package:thedogapi/Cofig/strings.dart';
import 'package:thedogapi/Cofig/text_styles.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_palette.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_typography.dart';


class DogThemes {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: VietStrings.appPrimaryFontName,
      // scaffoldBackgroundColor: PawAppColors.pawWhite,
      brightness: Brightness.light,
      extensions: <ThemeExtension<dynamic>>[
        const PawPallete(
          textColor: pawBlack,
          backgroundColor: pawWhite,
          primaryColor: primaryColor,
        ),
        DogTypography(
          large: PawsTextStyle.large,
          medium: PawsTextStyle.medium,
          small: PawsTextStyle.small,
        ),
      ],
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: VietStrings.appPrimaryFontName,
      // scaffoldBackgroundColor: PawAppColors.pawBlack,
      brightness: Brightness.dark,
      extensions: <ThemeExtension<dynamic>>[
        const PawPallete(
          textColor: pawWhite,
          backgroundColor: pawBlack,
          primaryColor: primaryColor,
        ),
        DogTypography(
          large: PawsTextStyle.large,
          medium: PawsTextStyle.medium,
          small: PawsTextStyle.small,
        ),
      ],
    );
  }
}
