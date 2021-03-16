import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import 'address_search.dart';
import 'suggestion.dart';

class AddSpotForm extends StatefulWidget {
  @override
  _AddSpotFormState createState() => _AddSpotFormState();
}

class _AddSpotFormState extends State<AddSpotForm> {

  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
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
          TextField(
            readOnly: true,
            onTap: () async {
              final sessionToken = Uuid().v4();
              final result = await showSearch(
                context: context,
                delegate: AddressSearch(sessionToken),
              );
              // This will change the text displayed in the TextField
              if (result != null) {
                setState(() {
                  _controller.text = result.description;
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
          buildSaveButton(),
        ],
      ),
    );
  }

  Padding buildSaveButton() {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: InkWell(
            onTap: () {
              //TODO: implement saving location
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
                      ranking = 2;
                    });
                  },
                  child: Icon(ranking > 1 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent, size: 50,)),
              InkWell
                (
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      ranking = 3;
                    });
                  },
                  child: Icon(ranking > 2 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,size: 50,)),
              InkWell
                (
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      ranking = 4;
                    });
                  },
                  child: Icon(ranking > 3 ? Icons.star : Icons.star_border_outlined, color: Colors.amberAccent,size: 50,)),
              InkWell
                (
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
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
            suffixIcon: Icon(Icons.location_on_outlined),
          ),
        );
  }
}
