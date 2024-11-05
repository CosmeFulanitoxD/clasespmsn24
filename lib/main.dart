import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttersample1/firebase_options.dart';
import 'package:fluttersample1/provider/test_provider.dart';
import 'package:fluttersample1/screens/detail_popular_screen.dart';
import 'package:fluttersample1/screens/home_screen.dart';
import 'package:fluttersample1/screens/login_screen.dart';
import 'package:fluttersample1/screens/movies_screen.dart';
import 'package:fluttersample1/screens/movies_screen_firebase.dart';
import 'package:fluttersample1/screens/popular_screen.dart';
import 'package:fluttersample1/screens/register.dart';
import 'package:fluttersample1/settings/global_values.dart';
import 'package:fluttersample1/settings/theme_settings.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.banthemeDark,
        builder: (context, value, Widget) {
          return ChangeNotifierProvider(
            create: (context) => TestProvider(),
            child: MaterialApp(
              title: 'Material App',
              theme: GlobalValues.banthemeDark.value
                  ? ThemeSettings.darkTheme()
                  : ThemeSettings.lightTheme(),
              debugShowCheckedModeBanner: false,
              home: MoviesScreenFirebase(),
              routes: {
                "/home": (context) => HomeScreen(),
                "/db": (context) => MoviesScreen(),
                "/apiscreen": (context) => PopularScreen(),
                "/details": (context) => DetailPopularScreen(),
                "/firebasemovies": (context) => MoviesScreenFirebase(),
              },
            ),
          );
        });
  }
}
