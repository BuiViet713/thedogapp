import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:shimmer/main.dart';
import 'package:thedogapi/Cofig/app/app_locator.dart';
import 'package:thedogapi/Cofig/theme.dart';
import 'package:thedogapi/core/navigation/navigator_key.dart';
import 'package:thedogapi/core/navigation/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        builder: (context, child) {
          return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: MaterialApp(
                    themeMode: ThemeMode.system,
                    theme: DogThemes.lightTheme,
                    onGenerateRoute: AppRoute.getRoute,
                    darkTheme: DogThemes.darkTheme,
                    debugShowCheckedModeBanner: false,
                    routes: AppRoute().routes,
                    navigatorKey: NavigatorKey.appNavigatorKey,
                    initialRoute: AppRoute.splashScreen,
                  ),
                );
              });
        });
  }
}
