import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/trip_details_by_id.dart';
// import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
// import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
// import 'package:transport_booking_system_passenger_mobile/models/route.dart';
// import 'package:transport_booking_system_passenger_mobile/views/pages/trip_details.dart';
import 'package:transport_booking_system_passenger_mobile/views/shared_widgets/page_widget.dart';

import 'auth.dart';

class GetTurnByRouteID extends StatefulWidget {
  // final String uid;
  // final String token;
  // final String startingDestination;
  // final String endingDestination;
  // final String journeyDate;
  // RouteDetails({this.uid, this.token, this.startingDestination, this.endingDestination, this.journeyDate});
  GetTurnByRouteID(
    
  );
  
  @override
  _GetTurnByRouteIDState createState() => _GetTurnByRouteIDState();
}

class _GetTurnByRouteIDState extends State<GetTurnByRouteID> {
  SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String routeId;
  String journeyDate = DateTime.now().toString();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        journeyDate = selectedDate.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: PageTitleHomePage(),
        actions: <Widget>[
          //   FlatButton(
          //     child: Text(
          //       "Find route",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 18.0,
          //       ),
          //     ),
          //     onPressed: () {
          //       sharedPreferences.clear();
          //       // shoule make changes to shared preference
          //       Navigator.of(context).pushReplacement(
          //         MaterialPageRoute(builder: (context) => SearchRoute())
          //       );
          //     },
          //   ),
          FlatButton(
            child: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              sharedPreferences.clear();
              // shoule make changes to shared preference
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "routeId",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Enter starting destination' : null,
                    onChanged: (val) {
                      setState(() => routeId = val);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  new DropdownButton<String>(
  items: <String>['A', 'B', 'C', 'D'].map((String value) {
    return new DropdownMenuItem<String>(
      value: value,
      child: new Text(value),
    );
  }).toList(),
  onChanged: (_) {},
),
SizedBox(
height: 40,
),
                  // Container(
                  //   alignment: Alignment(0, 0),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       labelText: "Ending Destination ",
                  //       labelStyle: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 20,
                  //       ),
                  //     ),
                  //     validator: (val) =>
                  //         val.isEmpty ? 'Enter ending destination' : null,
                  //     onChanged: (val) {
                  //       // setState(() => endingDestination = val);
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Find Buses",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        color: Colors.green[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TripDetailsById(
                                // uid: uid,
                                // token: token,
                                // startingDestination: startingDestination,
                                // endingDestination: endingDestination,
                                // journeyDate: journeyDate,
                                routeId:routeId,
                              )
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
