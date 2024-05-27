import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:travel_agency/flight_booking_module/flights_details_screen.dart';
import 'package:travel_agency/flight_booking_module/flight_model.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;
  final String fullName;
  final bool isClickable;

  int? value;
  FlightCard(
      {required this.flight,
      required this.fullName,
      required this.isClickable,
      this.value});

  _cityStyle(code, cityName, time) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              code,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              cityName,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              time,
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isClickable
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FlightDetailScreen(
                      passengerName: fullName,
                      flight: flight,
                    )))
            : null;
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _cityStyle(flight.from, flight.fromCity, flight.departTime),
                    Icon(Icons.airplanemode_active),
                    _cityStyle(flight.to, flight.toCity, flight.arriveTime),
                  ],
                ),
                Center(
                  child:value!=null?Text(
                    "\$" + (flight.price*value!).toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ): Text(
                    "\$" + flight.price.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
