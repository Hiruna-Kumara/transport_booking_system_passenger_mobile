import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/routesDropdown.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/home.dart';
// import 'package:transport_booking_system_passenger_mobile/views/pages/route_details.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/trip_details_by_id.dart';
// import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
// import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
// import 'package:transport_booking_system_passenger_mobile/models/route.dart';
// import 'package:transport_booking_system_passenger_mobile/views/pages/trip_details.dart';
import 'package:transport_booking_system_passenger_mobile/views/shared_widgets/page_widget.dart';

import 'auth.dart';

class GetTurnByRouteID extends StatefulWidget {
  GetTurnByRouteID();

  @override
  _GetTurnByRouteIDState createState() => _GetTurnByRouteIDState();
}

class _GetTurnByRouteIDState extends State<GetTurnByRouteID> {
  SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String routeId;
  String journeyDate = DateTime.now().toString();
  bool _isLoading;
  // bool _isLoadingLogged=true;
  String errorMessage;
  APIResponse<List<RoutesDropdown>> _apiResponse;
  final AuthController _auth = AuthController();
  List<RoutesDropdown> dropdownDetails;
  List<String> dropdownList = [];
  String holder;
  String dropdownValue;

  String uid;
  String token;


  @override
  void initState() {
    checkLoginStatus();
    // _isLoadingLogged:
    _fetchRouteDropdown();
    super.initState();
  }

  _fetchRouteDropdown() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await _auth.routesDropdownDisplay();
    setState(() {
      _isLoading = false;
      if (_apiResponse.error) {
        errorMessage = _apiResponse.errorMessage;
      } else {
        dropdownDetails = _apiResponse.data;
      }
    });
    // print('success dropdown');
    // print(_apiResponse.data);
    // print(_apiResponse.error);
    // print(_apiResponse.errorMessage);
    // print('${dropdownDetails[0].id}');
    for (var i = 0; i < dropdownDetails.length; i++) {
      dropdownList.add('${dropdownDetails[i].id}');
    }
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              LoginPage())); // if user is not logged in navigate to sign in page
    } else {
      // setState(() {
      //   _isLoadingLogged = true;
      // });
      uid = sharedPreferences.getString("uid");
      token = sharedPreferences.getString("token");
      // print(uid + "   uid in search by route");
      // setState(() {
      //   _isLoadingLogged = false;
      // });
    }
  }

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  // final RoutesDropdown routesDropdown=dropdownDetails;
  @override
  Widget build(BuildContext context) {
    // return _isLoading ? Center(child: CircularProgressIndicator()) : Scaffold(
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            // onPressed: () => Navigator.of(context).pop(),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home()))),
        title: PageTitleHomePage(),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        // title: PageTitleHomePage(),
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // body: SingleChildScrollView(
              child: Card(
                margin: EdgeInsets.all(15.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Choose Route Number Below",
                          style: new TextStyle(
                            fontSize: 20.0,
                            // color: Colors.yellow,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        new DropdownButton<String>(
                          // dropdownColor: Colors.black,
                          value: dropdownValue,
                          
                          // items: <String>['${dropdownDetails[0].id}', 'B', 'C', 'D'].map((String value) {
                          items: dropdownList.map((String value) {
                            // items:dropdownList{
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String data) {
                            setState(() {
                              dropdownValue = data;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
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
                                            uid: uid,
                                            token: token,
                                            // startingDestination: startingDestination,
                                            // endingDestination: endingDestination,
                                            // journeyDate: journeyDate,

                                            routeId: dropdownValue,
                                          )));
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
