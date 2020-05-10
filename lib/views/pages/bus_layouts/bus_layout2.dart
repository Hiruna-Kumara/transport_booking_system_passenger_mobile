import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';

class BusLayout2 extends StatefulWidget {
  final List<BusSeat> busSeatDetails;
  BusLayout2({this.busSeatDetails});
  
  @override
  _BusLayout2State createState() => _BusLayout2State();
}

class _BusLayout2State extends State<BusLayout2> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: generateExpanded(context),
      ),
    );
  }

  // create the bus layout
  List<Widget> generateExpanded(BuildContext context) {
    final children = <Widget>[];
    children.add(Expanded(
      flex: 1,
      child: firstRow(context, 0),
    ));
    for (var i = 2; i < 27; i = i+4) {
      children.add(Expanded(
        flex: 1,
        child: busRow(context, i),
      ));
    }
    return children; 
  }

  Widget firstRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: busSeat(context, index)),
        Expanded(flex:1,child: busSeat(context, index+1)),
      ],
    );
  }

  Widget busRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: busSeat(context, index)),
        Expanded(flex:1,child: busSeat(context, index+1)),
        Expanded(flex:1,child: busSeat(context, index+2)),
        Expanded(flex:1,child: busSeat(context, index+3)),
      ],
    );
  }

  Widget busSeat(BuildContext context, int index) {
    return Container(
      margin:EdgeInsets.symmetric(horizontal:10.0,vertical: 5.0),
      child: FlatButton(
        child: Center(
          child: Text(
            widget.busSeatDetails[index].seatID,
            style: TextStyle(color: Colors.grey[900]),
          )
        ),
        color: widget.busSeatDetails[index].booked? Colors.green[500] : Colors.amber[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        onPressed: () async {}, 
      ),
    );
  }
}