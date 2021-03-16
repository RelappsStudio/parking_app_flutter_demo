import 'package:flutter/widgets.dart';
import 'package:simple_parking_app/add_spot_screen/add_spot_screen.dart';
import 'package:simple_parking_app/map_screen/map_screen.dart';

final Map<String, WidgetBuilder> routes = {
MapScreen.routeName: (context) => MapScreen(),
AddSpotScreen.routeName: (context) => AddSpotScreen(),
};