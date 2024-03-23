import 'package:flutter/material.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_palette.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_typography.dart';
import 'package:thedogapi/core/utls/extensions/extensions.dart';

// import 'package:paws/src/core/utls/extensions/extensions.dart';
import 'package:thedogapi/Cofig/shared/logger.dart';

class PawWidgetsSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const PawWidgetsSearchBar({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final DogTypography? typography =
        context.appTheme.extension<DogTypography>();
    final PawPallete? palette = context.appTheme.extension<PawPallete>();
    return TextField(
      cursorColor: palette!.primaryColor,
      controller: controller,
      onChanged: (val) {
        Logger.logInfo(val);
        if (onChanged != null) onChanged!(val);
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 12),
          border: InputBorder.none,
          hintText: hintText ?? "Search for breeds",
          hintStyle:
              typography?.medium?.copyWith(color: const Color(0xFF9C9C9C))),
    );
  }
}
