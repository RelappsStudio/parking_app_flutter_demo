import 'package:flutter/material.dart';
import 'package:simple_parking_app/add_spot_screen/add_spot_screen.dart';

import 'components/body.dart';

class MapScreen extends StatelessWidget {
  static String routeName = '/map_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, AddSpotScreen.routeName);},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Body(),
    );
  }
}
