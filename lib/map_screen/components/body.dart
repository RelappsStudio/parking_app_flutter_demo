import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_parking_app/main.dart';
import 'package:simple_parking_app/place_model.dart';

import '../../database_hepler.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Map<String, Marker> _markers = {};

  GoogleMapController mapController;

  DatabaseHelper _databaseHelper = DatabaseHelper();
  final LatLng _center = const LatLng(0.0, 0.0);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final places = await _databaseHelper.getPlaces();
    setState(() {
      _markers.clear();
      for (final place in places)
        {
          final marker = Marker(
            onTap: () {
              _showPlaceDetailsDialog(place);
            },
            markerId: MarkerId(place.name),
            position: LatLng(double.parse(place.lat), double.parse(place.lon)),
            infoWindow: InfoWindow(
              title: place.name,
              snippet: '${place.description} \n Rated: \n ${place.rating} stars'
            ),
          );
          _markers[place.name] = marker;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 5.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }


  Future<void> _showPlaceDetailsDialog(ParkingPlace place) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(place.name)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(place.description),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Text('Rated:'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(place.rating > 0 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,),
                    Icon(place.rating > 1 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,),
                    Icon(place.rating > 2 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,),
                    Icon(place.rating > 3 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,),
                    Icon(place.rating > 4 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,),
                  ],
                )

              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              _databaseHelper.deletePlace(place.id);
              RestartWidget.restartApp(context);
                }, child: Text('Delete')),
            TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Dismiss'))
          ],
        );
      },
    );
  }
}


