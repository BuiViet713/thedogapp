import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thedogapi/pages/home/presenter/home_screen.dart';
import 'package:thedogapi/pages/home/presenter/sub_breed_view.dart';
import 'package:thedogapi/pages/login.dart';
import 'package:thedogapi/pages/navbar_roots.dart';
import 'package:thedogapi/pages/splash/presentater/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String subBreedView = '/subBreedView';
  static const String loginView = '/LoginPaghe';
  static const String navBarRoots = '/NavBarRoots';
  final routes = {
    splashScreen: (context) => const SplashScreen(),
  };

  static Route getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case homeScreen:
      //   return _getPageRoute(routeSettings, HomeScreen());

      case loginView:
        return _getPageRoute(routeSettings, LoginPage());

      case navBarRoots:
        return _getPageRoute(routeSettings, NavBarRoots());

      case subBreedView:
        SubBreedArgument args = routeSettings.arguments as SubBreedArgument;

        return _getPageRoute(
            routeSettings,
            SubBreedViewScreen(
              subBreedArgument: args,
            ));

      default:
        return _getPageRoute(
          routeSettings,
          const SplashScreen(),
        );
    }
  }

  static Route _getPageRoute(
    RouteSettings routeSettings,
    Widget screen, {
    bool isFullScreen = false,
  }) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        settings: routeSettings,
        builder: (context) => screen,
        fullscreenDialog: isFullScreen,
      );
    }
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) => screen,
      fullscreenDialog: isFullScreen,
    );
  }
}
