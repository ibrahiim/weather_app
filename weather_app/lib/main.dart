import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/ui/app.dart';

import 'blocs/weather_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final PreferencesRepository preferencesRepository = PreferencesRepository();
  final WeatherRepository addressRepository = WeatherRepository();
  final Repository repository = Repository(addressRepository,preferencesRepository);

  final WeatherCubit companyCubit = WeatherCubit(repository);
  await companyCubit.loadCompanies();


  runApp(
      MultiProvider(
        providers: [
          Provider<WeatherCubit>(create: (_) => companyCubit),
          Provider<Repository>(create: (_) => repository),
        ],
        child: const MdsApp(),
      )


  );
}

