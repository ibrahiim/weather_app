

import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/weather_repository.dart';

class Repository {
  final PreferencesRepository _preferencesRepository;

  Repository(this._weatherRepository,this._preferencesRepository);

  final WeatherRepository _weatherRepository;

  Future<Weather> searchWeathers(String query) {
    return _weatherRepository.fetchWeather(query);
  }
  Future<void> removeWeathers(List<Weather> weathers,String query) async {
    _preferencesRepository.deleteWeather(weathers,query);
  }

  Future<void> saveWeathers(List<Weather> weathers) async {
    _preferencesRepository.saveWeather(weathers);
  }
  Future<List<Weather>> loadWeathers() async =>_preferencesRepository.loadWeathers();
}