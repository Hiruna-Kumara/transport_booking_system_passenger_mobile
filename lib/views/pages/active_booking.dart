import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/controllers/authController.dart';
import 'package:transport_booking_system_passenger_mobile/models/apiResponse.dart';
import 'package:transport_booking_system_passenger_mobile/models/busBookingData.dart';
// import 'package:intl/intl.dart';
import 'package:transport_booking_system_passenger_mobile/shared_functions.dart';

class ActiveBooking extends StatefulWidget {
  final String uid;
  final String token;
  ActiveBooking({this.uid, this.token});

  @override
  _ActiveBookingState createState() => _ActiveBookingState();
}

class _ActiveBookingState extends State<ActiveBooking> {
 final AuthController _auth = AuthController();
  APIResponse<List<BusBookingData>> _apiResponse;
  final SharedFunctions sharedFunctions = SharedFunctions();
  List<BusBookingData> activeBookings; 
  bool _isLoading;
  String errorMessage;

  @override
  void initState() {
    _fetchBookingDetails();
    super.initState();
  }

  _fetchBookingDetails() async {
    setState(() { _isLoading = true; });
    _apiResponse = await _auth.getActiveBookings(widget.uid, widget.token);
    setState(() { 
      _isLoading = false; 
      if (_apiResponse.error){
        errorMessage = _apiResponse.errorMessage;
      } else {
        activeBookings = _apiResponse.data;
        activeBookings.sort((a, b) => sharedFunctions.getTimeDifference(sharedFunctions.getDateTime(a.departureTime)).compareTo(sharedFunctions.getTimeDifference(sharedFunctions.getDateTime(b.departureTime))));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Active Bookings',
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
      body: Container(
        child: Stack(
          children: <Widget>[
            _isLoading? Center(child: CircularProgressIndicator()) : Container(
                child: _apiResponse.error? SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
                    color: Colors.grey[100],
                    child: Center(
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
                  ),
                ) : activeBookings.length == 0 ? SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 40),
                    color: Colors.grey[100],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: Text(
                          "No active bookings",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ) : 
                ListView.builder(
                  itemCount: activeBookings.length,
                  itemBuilder: (context, index) {
                    return ActiveBookingTile(uid:widget.uid, token:widget.token, activeBooking: activeBookings[index]);
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveBookingTile extends StatelessWidget {
  final String uid;
  final String token;
  final BusBookingData activeBooking;
  ActiveBookingTile({this.uid, this.token, this.activeBooking});

  final SharedFunctions sharedFunctions = SharedFunctions();

  _getDateTime(Map<String, dynamic> dateTime){
    int inSeconds = dateTime['_seconds'];
    var date = new DateTime.fromMillisecondsSinceEpoch(inSeconds * 1000);
    return date;
  }

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
              // Text('Starting Station - ${route.startStation}'),
              Text('${activeBooking.busNumber} - ${activeBooking.startStation} to ${activeBooking.endStation}'),
              SizedBox(
                height: 10,
              ),
              // Text('End Station - ${route.endStation}'),
              Text('${sharedFunctions.formatDateTime(_getDateTime(activeBooking.departureTime))} to ${sharedFunctions.formatDateTime(_getDateTime(activeBooking.arrivalTime))}'),
              
              SizedBox(
                height: 10,
              ),
              Text('Seat Number ${activeBooking.seatId} - LKR ${activeBooking.price}'),
              SizedBox(
                height: 10,
              ),
              // Text('Bus Type - ${route.busType}'),
              
              Text(
                'Payment ID - ${activeBooking.paymentId}',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Conductor Contact Number -  '+activeBooking.conductorContact
              ),
              // '${route.turnId}' == null? SizedBox(
              //   height: 10,
              // ) 
              // : 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    child: Text(
                      "Cancel Booking",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    onPressed: () {
                      
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
