import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/home.dart';
import 'package:weather_app/ui/screens/extract_weather.dart';

class MdsApp extends StatelessWidget {
  const MdsApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/extract_weather': (context) => Extract_weather(),
        '/home': (context) => Home(),
      },
      initialRoute: '/home',
      // home: Home(),
    );
  }
}