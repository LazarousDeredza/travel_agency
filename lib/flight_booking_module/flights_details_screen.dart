import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:travel_agency/flight_booking_module/flight_booking_button.dart';
import 'package:travel_agency/flight_booking_module/flight_card.dart';
import 'package:travel_agency/flight_booking_module/flight_model.dart';
import 'package:travel_agency/hotel_booking_module/core/app_export.dart';

class FlightDetailScreen extends StatefulWidget {
  final String passengerName;
  final Flight flight;

  FlightDetailScreen({required this.passengerName, required this.flight});

  @override
  State<FlightDetailScreen> createState() => _FlightDetailScreenState();
}

class _FlightDetailScreenState extends State<FlightDetailScreen> {
  DateTime _selectedDate = DateTime.now();
  final _startdateController = TextEditingController();
  //final _enddateController = TextEditingController();

  final int initialValue = 1;
  final int minValue = 1;
  final int maxValue = 50;
  final int step = 1;

  late final Function(int)? onValueChanged = (value) {};

  late TextEditingController _controller = TextEditingController();
  int _value = 1;

  late DateTime? picked = DateTime.now();

  void _selectDate() async {
    picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked!;
        _startdateController.text =
            DateFormat('yyyy-MM-dd HH:MM').format(picked!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _value = initialValue;
    _controller = TextEditingController(text: _value.toString());
  }

  void _incrementValue() {
    _setValue(_value + step);
  }

  void _decrementValue() {
    _setValue(_value - step);
  }

  void _setValue(int newValue) {
    if (newValue >= minValue && newValue <= maxValue) {
      setState(() {
        _value = newValue;
        _controller.text = _value.toString();
        if (onValueChanged != null) {
          onValueChanged!(_value);
          // endDate=picked!.add(Duration(days:_value ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getRichText(title, name) {
      return RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: title, style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: name, style: TextStyle(color: Colors.grey)),
            ]),
      );
    }

    final _passengerDetailsCard = Card(
      elevation: 5.0,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 400.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getRichText("Passenger ", widget.passengerName),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(right: 27.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1.v, left: 20),
                          child: Text(
                            "Date",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _startdateController,
                                  readOnly: true,
                                  onTap: _selectDate,
                                  decoration: InputDecoration(
                                    hintText: 'Select a date',
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                    'Flight Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getRichText(
                    "Flight : ",
                    "ZW" +
                        Random().nextInt(100).toString() +
                        "AN" +
                        Random().nextInt(10).toString()),
                SizedBox(
                  width: 10.0,
                ),
                getRichText("Class ", "Commercial ")
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Number of passengers",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.h),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: _decrementValue,
                            icon: Icon(Icons.remove),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _setValue(int.parse(value));
                                } else {
                                  _setValue(1);
                                }
                              },
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: _incrementValue,
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getRichText("Seat ", Random().nextInt(100).toString() + "C"),
                SizedBox(
                  width: 10.0,
                ),
                getRichText("Gate ", Random().nextInt(10).toString() + "A")
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              color: Colors.amber,
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.30,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: <Widget>[
                    FlightCard(
                      flight: widget.flight,
                      isClickable: false,
                      fullName: widget.passengerName,
                      value: _value,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    _passengerDetailsCard,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FlightBookingButton(
          flight: widget.flight,
          numberOfPassengers: _value,
          StartDate: picked.toString(),
          fightNumber: "ZW" +
              Random().nextInt(100).toString() +
              "AN" +
              Random().nextInt(10).toString(),
          totalAmount: widget.flight.price * _value),
    );
  }
}
