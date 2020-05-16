import 'package:flutter/material.dart';

class BusBook extends StatefulWidget {
  final int count;
  final List<int> selectedSeatNumbers;
  BusBook({this.count, this.selectedSeatNumbers});

  @override
  _BusBookState createState() => _BusBookState();
}

class _BusBookState extends State<BusBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          'Book Bus',
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              "No of seats ${widget.count}"
            ),
            Text(
              "seat numbers:- ${widget.selectedSeatNumbers}"
            )
          ],
        ),
      ),
    );
  }
}