import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'dart:convert';

import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/preferences_repository.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/ui/screens/search_weather.dart';

import 'home.dart';


String city = "Angers";
class Extract_weather extends StatelessWidget {
  final Weather _weather;
  Extract_weather(this._weather,{Key key}) : super(key: key);
  final Repository repository = Repository(WeatherRepository(),PreferencesRepository());





 // final Weather _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),

      body :

      Column(
        children: [
          CurrentWeather(_weather), TodayWeather()
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () async {
          await Navigator.of(context).pushNamed('/home') ;

        },

        child: Icon(Icons.arrow_back_sharp),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,




    );
  }
}

class CurrentWeather extends StatefulWidget {
 final Weather weather;

  CurrentWeather(this.weather);

 Weather getweather(){
   return this.weather;
 }

  final Repository repository = Repository(WeatherRepository(),PreferencesRepository());


  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}
class _CurrentWeatherState extends State<CurrentWeather> {




   Weather _weather= Weather(8,6,'Clouds','Monday',2,89,"assets/sunny.png",7,'10','Angers');
  @override
  Widget build(BuildContext context) {

    if (widget.weather!=null){
      _weather=widget.weather;
    };
    return  GlowContainer(
      height: MediaQuery.of(context).size.height - 230,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 50, left: 30, right: 30),
      glowColor: Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: SingleChildScrollView(child:Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return Home();
                  }));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Add favorite ",
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

                  Icon(CupertinoIcons.map_fill, color: Colors.white),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                child :Icon(CupertinoIcons.search, color: Colors.white
                ),
              ),

            ],
          ),

          Container(
            height: 230,
            child: Stack(
              children: [

                Image(
                  image: AssetImage(_weather.image),
                  fit: BoxFit.fill,
                ),
                SizedBox(
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
                            style: TextStyle(
                                height: 0.1,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),

                          Text(_weather.name,
                              style: TextStyle(
                                fontSize: 25,
                              )),

                          Text(_weather.day,
                              style: TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      )),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
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
  ExtraWeather(this.temp);


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              temp.wind.toString() + " Km/h",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Wind",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              temp.humidity.toString() + " %",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
              ),

            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 30,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*WeatherWidget(todayWeather[0]),
                  WeatherWidget(todayWeather[1]),
                  WeatherWidget(todayWeather[2]),
                  WeatherWidget(todayWeather[3])*/
                ]),
          )
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
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
}
