import 'package:flutter/material.dart';


class Home extends StatefulWidget {
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
        title: const Text('Weather app',
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
    );
  }
}
