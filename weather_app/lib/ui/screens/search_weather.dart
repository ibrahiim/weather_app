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
      backgroundColor: const Color(0xff030317),

      body: Column(

        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: const Color(0xFFf9f9f9),
                filled: true,
                hintText:"Enter a city Name"
            ),
     textInputAction: TextInputAction.search,
    onSubmitted: (value)async {
    if(value.isNotEmpty) {
      final Weather _weather = await widget.repository
          .searchWeathers(value);
      if(_weather==null){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: const Color(0xFFf9f9f9),
            title:const Text("City not found"),
            content: const Text("Please check the city name"),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text("Ok"))
            ],
          );
        });
      }
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
