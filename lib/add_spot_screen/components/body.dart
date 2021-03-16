import 'package:flutter/material.dart';
import 'package:simple_parking_app/add_spot_screen/components/add_spot_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text('Create new parking spot',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                AddSpotForm(),
              ],
            )
        ),
      ),
    );
  }
}
