import 'package:flutter/material.dart';

import 'components/body.dart';

class MapScreen extends StatelessWidget {
  static String routeName = "/map_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

