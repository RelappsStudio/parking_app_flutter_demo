import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
            markerId: MarkerId(place.name),
            position: LatLng(double.parse(place.lat), double.parse(place.lon)),
            infoWindow: InfoWindow(
              title: place.name,
              snippet: place.description
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
}
