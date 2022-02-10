import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(String query) async {
    //Response response = await get('https://api-adresse.data.gouv.fr/search/?q=$query');

    //meteo https://api.openweathermap.org/data/2.5/weather?q=Paris&units=metric&appid=505a1ab449d9fd021df5e76f5cb20521
    var url ="https://api.openweathermap.org/data/2.5/weather?q=${query}&units=metric&appid=505a1ab449d9fd021df5e76f5cb20521";
    final Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      //final List<Weather> weathers = [];

      final Map<String, dynamic> json = jsonDecode(response.body);




      return Weather.fromWeaJson(json);
    } else {
      throw Exception('Failed to load weather');
    }
  }

}