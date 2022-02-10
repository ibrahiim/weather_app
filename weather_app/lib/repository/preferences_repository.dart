
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather.dart';

class PreferencesRepository {

  Future<void> saveWeather(List<Weather> weathers) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> listJson = [];
    for (final Weather weather in weathers) {
      listJson.add(weather.toJson());
    }

    prefs.setStringList('weathers', listJson);
  }

  Future<List<Weather>> loadWeathers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList('weathers');

    if(list == null) {
      return [];
    }

    final List<Weather> weathers = list.map((element) {
      return Weather.fromJson(element);
    }).toList();

    return weathers;
  }

}