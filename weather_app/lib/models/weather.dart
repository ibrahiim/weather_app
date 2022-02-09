import 'dart:convert';

class Weather {
   int max;
    int min;
    int current;
    String name;
    String day;
    int wind;
    int humidity;
    int chanceRain;
   String image;
    String time;
    String location;

   Weather(
          {this.max,
          this.min,
          this.name,
          this.day,
          this.wind,
          this.humidity,
          this.chanceRain,
          this.image,
          this.current,
          this.time,
          this.location});
}
   List<Weather> todayWeather = [
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
       location: "Angers");
