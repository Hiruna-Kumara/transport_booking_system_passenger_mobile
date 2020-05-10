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
            Menu(),
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
          ],
        ),
      );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green[500], 
              ),
              margin: EdgeInsets.fromLTRB(30.0,20.0,0,10),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.fromLTRB(0,10.0,20.0,0),
              child: Text(
                'Booked', 
                textAlign: TextAlign.left, 
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
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.amber[400], 
              ),
              margin: EdgeInsets.fromLTRB(25,20.0,5,10),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.fromLTRB(0,10.0,20,0),
              child: Text(
                'Available', 
                textAlign: TextAlign.left, 
                style: TextStyle(
                  fontSize: 15.0
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}