import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/ui/screens/home.dart';
import 'package:weather_app/ui/screens/extract_weather.dart';
import 'package:weather_app/ui/screens/search_weather.dart';
final Weather _weather= Weather(0,0,'Clouds',' ',0,0,"assets/sunny.png",0,'10','Search');
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
        '/extract_weather': (context) => Extract_weather(_weather),
        '/home': (context) => Home(),
        '/searchWeather': (context) => SearchWeather()

      },
      initialRoute: '/home',
      // home: Home(),
    );
  }
}