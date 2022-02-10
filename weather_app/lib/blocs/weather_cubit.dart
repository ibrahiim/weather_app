import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/repository.dart';

class WeatherCubit extends Cubit<List<Weather>> {
  WeatherCubit (this._repository) : super([]);
  final Repository _repository;
  void addCompany(Weather company) {
    emit([...state, company]);
    _repository.saveWeathers(state);
  }
  Future<void> loadCompanies() async {
    final List<Weather> companies = await _repository.loadWeathers();
    emit(companies);
  }
}
