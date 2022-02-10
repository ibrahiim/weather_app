import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_cubit.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repository.dart';

import 'extract_weather.dart';


class Home extends StatefulWidget {
  final Repository repository = Repository(WeatherRepository(),PreferencesRepository());
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text('Favorites',
         style: TextStyle(color: Colors.black),
        ),
          centerTitle: true,
          automaticallyImplyLeading: false,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        await Navigator.of(context).pushNamed('/extract_weather') ;

        },
        child: Icon(Icons.add),
      ),
      body:  BlocBuilder<WeatherCubit, List<Weather>>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.length,
            itemBuilder: (BuildContext context, int index) {
              Weather company = state[index];
              return ListTile(
                leading: const Icon(Icons.cloud),
                title: Text(company.location),
                onTap: () async {
                  final Weather _weather = await widget.repository
                      .searchWeathers(company.location);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Extract_weather(_weather),
                    ),
                  );
                }
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height:
                0
                ,
              );
            },
          );
        }, ),

    );
  }
}
