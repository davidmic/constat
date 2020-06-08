import 'package:convid/screens/all_countries.dart';
import 'package:convid/screens/bloc/all_countries_bloc.dart';
import 'package:convid/screens/navigator.dart';
import 'package:convid/screens/splash_screen.dart';
import 'package:convid/services/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllCountriesBloc()),
        ChangeNotifierProvider(create: (context) => MyLocator()),
      ],
      child: MaterialApp(
      theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/' : (context) => MySplashScreen(),
          '/navigator' : (context) => MyNavigator(),
          '/allcountries' : (context) => AllCountries(),
        },
      ),
    );
  }
}

