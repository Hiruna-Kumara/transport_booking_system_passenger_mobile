import 'package:flutter/material.dart';
import 'package:transport_booking_system_passenger_mobile/models/busSeat.dart';

class BusLayout4 extends StatefulWidget {
  final List<BusSeat> busSeatDetails;
  BusLayout4({this.busSeatDetails});

  @override
  _BusLayout4State createState() => _BusLayout4State();
}

class _BusLayout4State extends State<BusLayout4> {

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
    for (var i = 0; i < 33; i = i+4) {
      children.add(Expanded(
        flex: 1,
        child: busRow(context, i),
      ));
    }
    children.add(Expanded(
      flex: 1,
      child: oneBeforeLastRow(context, 36),
    ));
    children.add(Expanded(
        flex: 1,
        child: lastRow(context, 38),
      ));
    return children;  
  }

  Widget busRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: busSeat(context, index)),
        Expanded(flex:1,child: busSeat(context, index+1)),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: busSeat(context, index+2)),
        Expanded(flex:1,child: busSeat(context, index+3)),
      ],
    );
  }

  Widget oneBeforeLastRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: SizedBox()),
        Expanded(flex:1,child: busSeat(context, index)),
        Expanded(flex:1,child: busSeat(context, index+1)),
      ],
    );
  }

  Widget lastRow (BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(flex:1,child: busSeat(context, index)),
        Expanded(flex:1,child: busSeat(context, index+1)),
        Expanded(flex:1,child: busSeat(context, index+2)),
        Expanded(flex:1,child: busSeat(context, index+3)),
        Expanded(flex:1,child: busSeat(context, index+4)),
        Expanded(flex:1,child: busSeat(context, index+5)),
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