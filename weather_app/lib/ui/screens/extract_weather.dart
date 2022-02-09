import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';



class Extract_weather extends StatefulWidget {
  Extract_weather({Key? key}) : super(key: key);



  @override
  State<Extract_weather> createState() => _Extract_weatherState();
}

class _Extract_weatherState extends State<Extract_weather> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
       backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
        "Weather app",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,


      ),
      body: CurrentWeather(),

    );
  }
}
class CurrentWeather extends StatefulWidget {
  late final Function() updateData;

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {

  bool searchBar = false;
  bool updating = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(searchBar)
          setState(() {
            searchBar = false;
          });
      },
      child: GlowContainer(
        height: MediaQuery.of(context).size.height - 230,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        glowColor: Color(0xff00A1FF).withOpacity(0.5),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        color: Color(0xff00A1FF),
        spreadRadius: 5,
        child: SingleChildScrollView(child: Column(
          children: [
            Container(
              child: searchBar?
              TextField(
                focusNode: focusNode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    fillColor: Color(0xff030317),
                    filled: true,
                    hintText:"Enter a city Name"
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value)async{
                  //CityModel temp = await fetchCity(value);


                  updating = true;
                  setState(() {

                  });
                  widget.updateData();
                  searchBar = false;
                  updating = false;
                  setState(() {

                  });
                },
              )
                  :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    children: [
                      Icon(CupertinoIcons.map_fill, color: Colors.white),
                      GestureDetector(
                        onTap: (){
                          searchBar = true;
                          setState(() {

                          });
                          focusNode.requestFocus();
                        },
                        child: const Text(
                          " " ,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            Container(
              height: 430,
              child: Stack(
                children: [
                  Icon(
                    Icons.add_location  ,
                    //fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Center(
                        child: Column(
                          children: [
                            GlowText(
                              "11",
                              style: TextStyle(
                                  height: 0.1,
                                  fontSize: 150,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Angers",
                                style: TextStyle(
                                  fontSize: 25,
                                )),
                            Text("14",
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
            //ExtraWeather(currentTemp)
          ],
        ),),
      ),
    );
  }
}
