import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_parking_app/add_spot_screen/components/form_error.dart';
import 'package:simple_parking_app/add_spot_screen/components/place_service.dart';
import 'package:simple_parking_app/database_hepler.dart';
import 'package:simple_parking_app/errors.dart';
import 'package:simple_parking_app/place_model.dart';
import 'package:uuid/uuid.dart';

import 'address_search.dart';

class AddSpotForm extends StatefulWidget {
  @override
  _AddSpotFormState createState() => _AddSpotFormState();
}

class _AddSpotFormState extends State<AddSpotForm> {

  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String androidKey = 'AIzaSyCNdcZy-nP9FVoMaROjKn5172sieU7KugA';
  DatabaseHelper _databaseHelper = DatabaseHelper();
  LatLng lat_lng;
  String lat;
  String lon;
  String name;
  String description;
  int ranking = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          TextFormField(
            controller: _controller,
            readOnly: true,
            onTap: () async {
              final sessionToken = Uuid().v4();
              final result = await showSearch(
                context: context,
                delegate: AddressSearch(sessionToken),
              );
              // This will change the text displayed in the TextField
              if (result != null) {

                setState(() async{
                  _controller.text = result.description;
                  setState(() {
                    if (errors.contains(kNullAddressName))
                    {
                      errors.remove(kNullAddressName);
                    }
                  });
                  await getLatLng(result.placeId);
                });
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Location',
              hintText: 'Location of the parking spot',
              suffixIcon: Icon(Icons.location_on_outlined),
            ),
            validator: (value)
            {
              if (value.isEmpty && !errors.contains(kNullAddressName))
              {
                setState(() {
                  errors.add(kNullAddressName);
                });
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          buildDescFormField(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Text('Rating:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          buildRatingRow(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          FormError(errors: errors),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
          buildSaveButton(),
        ],
      ),
    );
  }

  Future<void> getLatLng(String placeID)
  async {
    final query = placeID;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    lat = first.coordinates.latitude.toString();
    lon = first.coordinates.longitude.toString();
  }

  Padding buildSaveButton() {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: InkWell(
            onTap: () {
              if (_formKey.currentState.validate())
                {
                  if (ranking == 0 && !errors.contains(kNullRating))
                    {
                      errors.add(kNullRating);
                    }
                  _formKey.currentState.save();
                  addPlace();
                }

            },
            child: Container(
              height: 50.0,
              decoration:  BoxDecoration(
                color: Colors.grey,
                borderRadius:  BorderRadius.circular(10.0),
              ),
              child:  Center(child:  Text('Save', style:  TextStyle(fontSize: 18.0, color: Colors.white),),),
            ),
          ),
        );
  }

  Future<void> addPlace()async {
    final  places = await _databaseHelper.getPlaces();
    await _databaseHelper.addPlace(ParkingPlace(places.length + 1, name, lat, lon, description, ranking));
  }

  SingleChildScrollView buildRatingRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell
                (
                borderRadius: BorderRadius.circular(50),
                onTap: () {

                  setState(() {
                    if (errors.contains(kNullRating))
                    {
                      errors.remove(kNullRating);
                    }
                    if (ranking == 1)
                      {
                        ranking = 0;
                      }
                    else{
                      ranking = 1;
                    }

                  });
                },
                  child: Icon(ranking > 0 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,size: 50,)),
              InkWell
                (
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      if (errors.contains(kNullRating))
                      {
                        errors.remove(kNullRating);
                      }
                      ranking = 2;
                    });
                  },
                  child: Icon(ranking > 1 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent, size: 50,)),
              InkWell
                (
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      if (errors.contains(kNullRating))
                      {
                        errors.remove(kNullRating);
                      }
                      ranking = 3;
                    });
                  },
                  child: Icon(ranking > 2 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,size: 50,)),
              InkWell
                (
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      if (errors.contains(kNullRating))
                      {
                        errors.remove(kNullRating);
                      }
                      ranking = 4;
                    });
                  },
                  child: Icon(ranking > 3 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,size: 50,)),
              InkWell
                (
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      if (errors.contains(kNullRating))
                      {
                        errors.remove(kNullRating);
                      }
                      ranking = 5;
                    });
                  },
                  child: Icon(ranking > 4 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,size: 50,)),
            ],
          ),
    );
  }

  TextFormField buildDescFormField() {
    return TextFormField(
          onSaved: (newValue) => description = newValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'Description',
            hintText: 'Describe the parking spot',
            suffixIcon: Icon(Icons.title),
          ),
      onChanged: (value)
      {
        setState(() {
          errors.remove(kNullDescription);
        });
      },
      validator: (value)
      {
        if (value.isEmpty && !errors.contains(kNullDescription))
          {
            setState(() {
              errors.add(kNullDescription);
            });
          }
        return null;
      },
        );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
          onSaved: (newValue) => name = newValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'Parking name',
            hintText: 'Name of the parking spot',
            suffixIcon: Icon(Icons.title),

          ),
      onChanged: (value)
      {
        setState(() {
          errors.remove(kNullPlaceName);
        });
      },
      validator: (value)
      {
        if (value.isEmpty && !errors.contains(kNullPlaceName))
        {
          setState(() {
            errors.add(kNullPlaceName);
          });
        }
        return null;
      },
        );
  }
}
