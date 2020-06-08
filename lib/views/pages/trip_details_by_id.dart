import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/route.dart';
import 'package:transport_booking_system_passenger_mobile/models/routeDataGetById.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/trip_details.dart';

class TripDetailsById extends StatefulWidget {
  final String uid;
  final String token;
  // final String startingDestination;
  // final String endingDestination;
  final String routeId;
  // final String journeyDate;
  TripDetailsById({this.uid, this.token, this.routeId});
  // this.startingDestination, this.endingDestination, this.journeyDate});

  @override
  _TripDetailsByIdState createState() => _TripDetailsByIdState();
}

class _TripDetailsByIdState extends State<TripDetailsById> {
  final AuthController _auth = AuthController();
  APIResponse<List<RouteDataGetById>> _apiResponse;
  List<RouteDataGetById> routeDetails;
  bool _isLoading;
  String errorMessage;

  @override
  void initState() {
    _fetchTurnDetailsByRoute();
    super.initState();
  }

  _fetchTurnDetailsByRoute() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await _auth.getTurnByRouteID(widget.routeId);
    setState(() {
      _isLoading = false;
      if (_apiResponse.error) {
        errorMessage = _apiResponse.errorMessage;
      } else {
        routeDetails = _apiResponse.data;
      }
    });
    print("*******************get the output");
    print(_apiResponse.data);
    print(_apiResponse.error);
    print(_apiResponse.errorMessage);
  }

  @override
  Widget build(BuildContext context) {
    // print(routeDetails.length);
    return Scaffold(
      
      appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Possible Routes',
            style: TextStyle(color: Colors.white),
          )),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _apiResponse.error
              ? SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
                    color: Colors.grey[100],
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topRight,
                          child: FlatButton.icon(
                            icon: Icon(Icons.refresh),
                            label: Text(
                              'Refresh',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            onPressed: () async {
                              // to load all the route details
                              _fetchTurnDetailsByRoute();
                              // print(object);
                            },
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                            child: Text(
                              "$errorMessage",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green[900],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              :
              // routeDetails[0].length
              routeDetails.length == 0
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: Text(
                        "No routes for the given stations",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: routeDetails.length,
                      itemBuilder: (context, index) {
                        // return PartialRouteDetailTile(uid: widget.uid, token: widget.token, fullRouteData: routeDetails[index]);
                        return;
                      }),
    );
  }
}

class FullRouteDetailTile extends StatelessWidget {
  final String uid;
  final String token;
  final List<RouteDataGetById> fullRouteData;
  FullRouteDetailTile({this.uid, this.token, this.fullRouteData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[400],
      margin: EdgeInsets.all(15.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: fullRouteData.length,
          itemBuilder: (context, index) {
            // return PartialRouteDetailTile(uid: uid, token: token, route: fullRouteData[index]);
            return;
          }),
    );
  }
}

class PartialRouteDetailTile extends StatelessWidget {
  final String uid;
  final String token;
  final RouteData route;
  PartialRouteDetailTile({this.uid, this.token, this.route});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.grey[200],
        margin: EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text('Route Name - ${route.routeName}'),
              SizedBox(
                height: 10,
              ),
              Text('Short Name - ${route.shortName}'),
              SizedBox(
                height: 10,
              ),
              Text('Departure Stop - ${route.departureStop}'),
              SizedBox(
                height: 10,
              ),
              Text('Arrival Stop - ${route.arrivalStop}'),
              SizedBox(
                height: 10,
              ),
              Text('Status - ${route.status}'),
              route.routeId == null
                  ? SizedBox(
                      height: 10,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          child: Text(
                            "Show Turn Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          color: Colors.green[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TripDetails(
                                    uid: uid,
                                    token: token,
                                    routeId: route.routeId)));
                            // show turn details
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// class RoutesDropdownDisplay extends State<TripDetailsById> {
//   final AuthController _auth = AuthController();
//   APIResponse<List<RouteDataGetById>> _apiResponse;
//   List<RouteDataGetById> routeDetails;
//   bool _isLoading;
//   String errorMessage;

//   void initState() {
//     _fetchTurnDetailsByRoute();
//     super.initState();
//   }

//   _fetchTurnDetailsByRoute() async {
//     setState(() {
//       _isLoading = true;
//     });
//     _apiResponse = await _auth.getTurnByRouteID(widget.routeId);
//     setState(() {
//       _isLoading = false;
//       if (_apiResponse.error) {
//         errorMessage = _apiResponse.errorMessage;
//       } else {
//         routeDetails = _apiResponse.data;
//       }
//     });
//     print("*******************get the output");
//     print(_apiResponse.data);
//     print(_apiResponse.error);
//     print(_apiResponse.errorMessage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
