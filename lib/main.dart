import 'package:flutter/material.dart';
import 'package:fluttersample1/screens/home_screen.dart';
import 'package:fluttersample1/screens/login_screen.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:fluttersample1/settings/theme_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.banthemeDark,
        builder: (context, value, Widget) {
          return MaterialApp(
            title: 'Material App',
            theme: GlobalValues.banthemeDark.value
                ? ThemeSettings.darkTheme()
                : ThemeSettings.lightTheme(),
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
            routes: {"/home": (context) => HomeScreen()},
          );
        });
  }
}
