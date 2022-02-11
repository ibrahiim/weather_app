import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_cubit.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:provider/provider.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        await Navigator.of(context).pushNamed('/extract_weather') ;

        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(child: BlocBuilder<WeatherCubit, List<Weather>>(
        builder: (context, state) {
          return  CupertinoScrollbar( child :Column(
            children: [
              Stack(children :[
          ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child:
            Image.asset(
            	                'assets/images.jfif',
            	                width: double.infinity,
                            height: 400,
            	                fit: BoxFit.cover,),),
              Container(
               decoration: const BoxDecoration(color: Colors.black38),
              ),
                Container(
                 padding: const EdgeInsets.all(100),
                  child: Column(
                    children: [
                      const SizedBox(height: 120,),
                      const Text("Weather app",
                      style: TextStyle(fontSize: 35, color: Colors.black),

                      ),
                      Image.asset(
                        'assets/images (1).jfif',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,)

                    ],


                  ),

                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Favorites",style: TextStyle(fontSize: 18, color: Colors.red),),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,

                  )

                ],

              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: state.length,
                itemBuilder: (BuildContext context, int index) {
                  Weather company = state[index];
                  return ListTile(
                    leading: const Icon(Icons.cloud),
                    title: Text(company.location,style: const TextStyle(fontSize: 18, color: Colors.white),),
                    trailing : const Icon(Icons.restore_from_trash),
                    onTap: () async {
                      final Weather _weather = await widget.repository
                          .searchWeathers(company.location);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Extract_weather(_weather),
                        ),
                      );
                    },
                    onLongPress: () async{
                      Provider.of<WeatherCubit>(context, listen: false).removeCompany(company);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );

                  },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height:
                    0
                    ,
                  );
                },
              ),
            ],
          ),
          );
        }, ),

    ),);
  }
}
