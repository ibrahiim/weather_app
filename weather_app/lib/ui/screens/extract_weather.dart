import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/weather_cubit.dart';

import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/ui/screens/search_weather.dart';

import 'home.dart';



class Extract_weather extends StatefulWidget {
  final Weather _weather;
  const Extract_weather(this._weather,{Key key}) : super(key: key);

  @override
  State<Extract_weather> createState() => _Extract_weatherState();
}

class _Extract_weatherState extends State<Extract_weather> {
  final Repository repository = Repository(WeatherRepository(),PreferencesRepository());

 // final Weather _weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030317),

      body :

      Column(
        children: [
          CurrentWeather(widget._weather), TodayWeather(widget._weather)
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () async {
          await Navigator.of(context).pushNamed('/home') ;

        },

        child: const Icon(Icons.arrow_back_sharp),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,




    );
  }
}

class CurrentWeather extends StatefulWidget {
 final Weather weather;

  CurrentWeather(this.weather, {Key key}) : super(key: key);


  final Repository repository = Repository(WeatherRepository(),PreferencesRepository());


  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}
class _CurrentWeatherState extends State<CurrentWeather> {





  @override
  Widget build(BuildContext context) {


      Weather  _weather=widget.weather;

    return  GlowContainer(
      height: MediaQuery.of(context).size.height - 230,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      glowColor: const Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      color: const Color(0xff00A1FF),
      spreadRadius: 5,
      child: SingleChildScrollView(child:Column(
        children: [
          GestureDetector(
            onTap: () {
              List<Weather> weathers =Provider.of<WeatherCubit>(context, listen: false).state;

              if(weathers.contains(_weather)==false){
                Provider.of<WeatherCubit>(context, listen: false).addCompany(_weather);
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return Home();
                  }));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Add to favorite ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,

                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                  const Icon(CupertinoIcons.map_fill, color: Colors.white),
              /*TextFormField(
                  initialValue: "Angers",
                onChanged: (value) async {
                  if(value.isNotEmpty) {
                    final Weather weather = await widget.repository
                        .searchWeathers(value);
                    setState(() {
                      _weather = weather;

                    });
                  }

                },
              ),*/
              GestureDetector(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return SearchWeather();
                        }));
                    setState(() {

                    });
                  },
                  child :Text(
                    " " + _weather.location,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return SearchWeather();
                      }));
                  setState(() {

                  });
                },
                child :const Icon(CupertinoIcons.search, color: Colors.white
                ),
              ),

            ],
          ),

          SizedBox(
            height: 230,
            child: Stack(
              children: [

                Image(
                  image: AssetImage(_weather.image),
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 10,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Center(

                      child: Column(
                        children: [

                          GlowText(
                            _weather.current.toString(),
                            style: const TextStyle(
                                height: 0.1,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),

                          Text(_weather.name,
                              style: const TextStyle(
                                fontSize: 25,
                              )),

                          Text(_weather.day,
                              style: const TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      )),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          ExtraWeather(_weather)
        ],
      ),),
    );
  }

}
class ExtraWeather extends StatelessWidget {
  final Weather temp;
  const ExtraWeather(this.temp, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              temp.wind.toString() + " Km/h",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Wind",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            const Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              temp.humidity.toString() + " %",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Humidity",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),

      ],
    );
  }
}

class TodayWeather extends StatelessWidget {
  final Weather weather;
  const TodayWeather(this.weather, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Today",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
              ),

            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 30,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.white),
                        borderRadius: BorderRadius.circular(35)),
                    child: Column(
                      children: [
                        Text(
                          weather.min.toString() + "\u00B0",
                          style: const TextStyle(fontSize: 20,color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Image(
                          image: AssetImage(weather.image),
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Temp min",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.white),
                        borderRadius: BorderRadius.circular(35)),
                    child: Column(
                      children: [
                        Text(
                          weather.feels.toString() + "\u00B0",
                          style: const TextStyle(fontSize: 20,color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Image(
                          image: AssetImage(weather.image),
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Feels like",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.white),
                        borderRadius: BorderRadius.circular(35)),
                    child: Column(
                      children: [
                        Text(
                          weather.max.toString() + "\u00B0",
                          style: const TextStyle(fontSize: 20,color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Image(
                          image: AssetImage(weather.image),
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Temp max",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                  )

                ]),
          )
        ],
      ),
    );
  }
}

/*class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget(this.weather);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.white),
          borderRadius: BorderRadius.circular(35)),
      child: Column(
        children: [
          Text(
            weather.current.toString() + "\u00B0",
            style: TextStyle(fontSize: 20,color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(weather.image),
            width: 50,
            height: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weather.time,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )
        ],
      ),
    );
  }
}*/
