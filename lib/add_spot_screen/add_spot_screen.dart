import 'package:flutter/material.dart';
import 'components/body.dart';

class AddSpotScreen extends StatelessWidget {
  static String routeName = '/add_spot_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(headline6: TextStyle(color: Colors.grey, fontSize: 20)),
        backgroundColor: Colors.white,
        title: Text('Add new parking spot'),
      ),
      body: Body(),
    );
  }
}
