import 'package:flutter/material.dart';
import 'package:thedogapi/Cofig/app/app_locator.dart';
import 'package:thedogapi/Cofig/assets.dart';
import 'package:thedogapi/Cofig/colors.dart';
import 'package:thedogapi/Cofig/shared/render_assets.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_palette.dart';
import 'package:thedogapi/Cofig/theme_extensions/app_typography.dart';
import 'package:thedogapi/core/navigation/routes.dart';
import 'package:thedogapi/core/utls/extensions/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      appRouter.pushNamedAndRemoveUntil(AppRoute.loginView, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DogTypography? typography =
        context.appTheme.extension<DogTypography>();
    final PawPallete? palette = context.appTheme.extension<PawPallete>();
    return Scaffold(
        backgroundColor: palette?.primaryColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF9948FF),
                    Color(0xFF8840E2),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              child: DogWidgetsRenderSvg(svgPath: dogSplash),
            ),
            Text(
              "Dogs App",
              style: typography?.large?.copyWith(
                color: pawWhite,
                fontWeight: FontWeight.bold,
              ),
            ).center
          ],
        ));
  }
}
