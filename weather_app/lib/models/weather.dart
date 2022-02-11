import 'dart:convert';
import 'package:intl/intl.dart';

class Weather {
   num max;
   num min;
   num feels;
   String current;
    String name;
    String day;
   String wind;
    String humidity;
   String image;
    String time;
    String location;

   Weather(
          this.max,
          this.min,
          this.feels,
          this.name,
          this.day,
          this.wind,
          this.humidity,
          this.image,
          this.current,
          this.time,
          this.location);
   String toJson() {
     return jsonEncode({
      'max':max,
     'min':min,
       'feels':feels,
     'current':current,
     'name':name,
     'day':day,
     'wind':wind,
     'humidity':humidity,
     'image' :image,
     'time' :time,
     'location' :location,

     });
   }

   factory Weather.fromJson(String json) {
     Map<String, dynamic> map = jsonDecode(json);
     return Weather(
       map['max'],
       map['min'],
       map['feels'],
       (map['current']).toString(),
       map['name'],
       map['day'],
       (map['wind']).toString(),
       (map['humidity']).toString(),
       map['image'],
       map['time'],
       map['location'],
       //LatLng(map['latitude'], map['longitude'])
     );
   }
   static String  findIcon(String name,bool type){
     if(type){
       switch(name){
         case "Clouds":
           return "assets/sunny.png";
           break;
         case "Rain":
           return "assets/rainy.png";
           break;
         case "Drizzle":
           return "assets/rainy.png";
           break;
         case "Thunderstorm":
           return "assets/thunder.png";
           break;
         case "Snow":
           return "assets/snow.png";
           break;
         default:
           return "assets/sunny.png";
       }
     }else{
       switch(name){
         case "Clouds":
           return "assets/sunny_2d.png";
           break;
         case "Rain":
           return "assets/rainy_2d.png";
           break;
         case "Drizzle":
           return "assets/rainy_2d.png";
           break;
         case "Thunderstorm":
           return "assets/thunder_2d.png";
           break;
         case "Snow":
           return "assets/snow_2d.png";
           break;
         default:
           return "assets/sunny_2d.png";
       }
     }
   }

     factory Weather.fromWeaJson(Map<String, dynamic> json) {
       DateTime date = DateTime.now();
       int hour = int.parse(DateFormat("hh").format(date));


     final String max = (json['main']['temp_max']).toString();
     final String min= (json['main']['temp_min']).toString();
     final String current = (json['main']['temp']).toString();
       final String feels = (json['main']['feels_like']).toString();
     final String name = (json['weather'][0]['main']).toString();
     final String day = DateFormat("EEEE dd MMMM").format(date);
     final String wind = (json['wind']['speed']).toString();
     final String humidity = (json['main']['humidity']).toString();
     final String image = findIcon(json['weather'][0]['main'], true);
     final String time= Duration(hours: hour+2).toString().split(":")[0]+":00";
     final String location=(json['name']).toString();


     /*final Map<String, dynamic> geometry = json['geometry'] ?? {};
    final List<dynamic> coordinates = geometry['coordinates'] ?? [];
    final double latitude = coordinates[1] ?? 0;
    final double longitude = coordinates[0] ?? 0;
    final LatLng position = LatLng(latitude, longitude);*/

       return Weather(
           num.parse(max).round()??0,
           num.parse(min).round()??0,
           num.parse(feels).round()??0,
           name,
           day,
           (num.parse(wind).round()??0).toString(),
      (num.parse(humidity).round()??0).toString(),
           image,
           (num.parse(current).round()??0).toString(),
           time,
           location);
   }
   @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is Weather && location == other.location;
  }
}
   /*List<Weather> todayWeather = [
      Weather(current: 23, image: "assets/rainy_2d.png", time: "10:00"),
      Weather(current: 21, image: "assets/thunder_2d.png", time: "11:00"),
      Weather(current: 22, image: "assets/rainy_2d.png", time: "12:00"),
      Weather(current: 19, image: "assets/snow_2d.png", time: "01:00")
   ];
   Weather currentTemp = Weather(
       current: 21,
       image: "assets/thunder.png",
       name: "Thunderstorm",
       day: "Monday, 17 May",
       wind: 13,
       humidity: 24,
       chanceRain: 87,
       location: "Angers");*/
