import 'package:flutter/material.dart';
import 'package:simple_parking_app/map_screen/map_screen.dart';
import 'package:simple_parking_app/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple parking app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
      routes: routes,
      initialRoute: MapScreen.routeName,
    );
  }
}
