import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout1.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout2.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout3.dart';
import 'package:transport_booking_system_passenger_mobile/views/pages/bus_layouts/bus_layout4.dart';

class BusLayoutWrapper extends StatefulWidget {
  final String busType;
  final List<BusSeat>  busSeatDetails;
  BusLayoutWrapper({this.busType,this.busSeatDetails});

  @override
  _BusLayoutWrapperState createState() => _BusLayoutWrapperState();
}

class _BusLayoutWrapperState extends State<BusLayoutWrapper> {
  @override
  Widget build(BuildContext context) {
      Widget layout; // return the layout according to the type of the bus
      if (widget.busType == "Type1"){
        layout = BusLayout1(busSeatDetails: widget.busSeatDetails);
      }
      if (widget.busType == "Type2"){
        layout = BusLayout2(busSeatDetails: widget.busSeatDetails);
      }
      if (widget.busType == "Type3"){
        layout = BusLayout3(busSeatDetails: widget.busSeatDetails);
      }
      if (widget.busType == "Type4"){
        layout = BusLayout4(busSeatDetails: widget.busSeatDetails);
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(
            'Seat Bookings',
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Menu()
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey[400], 
                ),
                width: double.infinity,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Front', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.grey[700],
                    ),
                  )
                )
              ),
            ),
            Expanded(
              flex: 8,
              child: layout,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: FlatButton(
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: FlatButton(
                    child: Text(
                      "Add To Waiting List",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    onPressed: () {
                      // Navigate to 'add to waiting list' page
                    },
                  ),
                )
              ),
            ),
          ],
        ),
      );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.green[500], 
                    ),
                    margin: EdgeInsets.fromLTRB(20.0,0.0,20.0,0),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.amber[400], 
                    ),
                    margin: EdgeInsets.fromLTRB(20.0,0.0,20.0,0),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey[700], 
                    ),
                    margin: EdgeInsets.fromLTRB(20.0,0.0,20.0,0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      'Booked', 
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize: 15.0
                      ),
                    )
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      'Available', 
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize: 15.0
                      ),
                    )
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Text(
                      'Selected', 
                      textAlign: TextAlign.center, 
                      style: TextStyle(
                        fontSize: 15.0
                      ),
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}