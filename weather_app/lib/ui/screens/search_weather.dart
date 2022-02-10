import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/ui/screens/extract_weather.dart';


class SearchWeather extends StatefulWidget {
  SearchWeather({Key key}) : super(key: key);
  final Repository repository = Repository(WeatherRepository(),PreferencesRepository());


  @override
  State<SearchWeather> createState() => _SearchWeatherState();
}

class _SearchWeatherState extends State<SearchWeather> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),

      body: Column(

        children: [
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Color(0xFFf9f9f9),
                filled: true,
                hintText:"Enter a city Name"
            ),
     textInputAction: TextInputAction.search,
    onSubmitted: (value)async {
    if(value.isNotEmpty) {
      final Weather _weather = await widget.repository
          .searchWeathers(value);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Extract_weather(_weather),
        ),
      );
    }
    }
          ),

        ],

      ),

    );
  }
}
