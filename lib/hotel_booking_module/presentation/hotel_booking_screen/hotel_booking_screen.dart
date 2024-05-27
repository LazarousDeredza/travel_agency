import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/add_tourist.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/first_tourist/first_tourist.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/paid/paid.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/second_tourist/second_tourist.dart';
import 'notifier/hotel_booking_notifier.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/booking_appbar.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/booking_button.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/booking_data.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/hotel_description.dart';
import 'widgets/buyer/buyer_info.dart';

class HotelBookingScreen extends ConsumerStatefulWidget {
  final Hotel hotel;
  final int totalAmount;
  final String selectedOption;

  const HotelBookingScreen(
      {required this.hotel,
      required this.totalAmount,
      required this.selectedOption,
      super.key});

  @override
  HotelBookingScreenState createState() => HotelBookingScreenState();
}

class HotelBookingScreenState extends ConsumerState<HotelBookingScreen> {
  ///DISPOSE CONTROLLERS, FOCUSNODES

  DateTime _selectedDate = DateTime.now();
  final _dateController = TextEditingController();

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  final int initialValue = 1;
  final int minValue = 1;
  final int maxValue = 50;
  final int step = 1;

  late final Function(int)? onValueChanged=(value) {
    
  };

  


  late TextEditingController _controller =TextEditingController();
  int _value = 1;

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
        }
      });
    }
  }

  @override
  void dispose() {
    // ref.watch(hotelBookingNotifier).firstNameController!.dispose();
    // ref.watch(hotelBookingNotifier).firstNameFocusNode!.dispose();
    // ref.watch(hotelBookingNotifier).lastNameController!.dispose();
    // ref.watch(hotelBookingNotifier).lastNameFocusNode!.dispose();
    // ref.watch(hotelBookingNotifier).birthDateController!.dispose();
    // ref.watch(hotelBookingNotifier).birthDateFocusNode!.dispose();
    // ref.watch(hotelBookingNotifier).nationalityController!.dispose();
    // ref.watch(hotelBookingNotifier).nationalityFocusNode!.dispose();
    // ref.watch(hotelBookingNotifier).passportNumberController!.dispose();
    // ref.watch(hotelBookingNotifier).passportNumberFocusNode!.dispose();
    // ref.watch(hotelBookingNotifier).passportExpiryController!.dispose();
    // ref.watch(hotelBookingNotifier).passportExpiryFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: BookingAppbar(),
          body: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 8.v),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5.v),
                      child: Column(
                        children: [
                          HotelDescription(
                            hotel: widget.hotel,
                          ),
                          SizedBox(height: 8.v),

                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(right: 27.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 1.v, left: 20),
                                        child: Text(
                                          "Date",
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                controller: _dateController,
                                                readOnly: true,
                                                onTap: _selectDate,
                                                decoration: InputDecoration(
                                                  hintText: 'Select a date',
                                                  suffixIcon: Icon(
                                                      Icons.calendar_today),
                                                ),
                                              ),
                                              SizedBox(height: 16.0),
                                              Text(
                                                  'Selected date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                            "Number of nights",
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
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    onChanged: (value) {
                                                      if (value.isNotEmpty) {
                                                        _setValue(int.parse(value));
                                                      } else {
                                                        _setValue(0);
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
                                ],
                              ),
                            ),
                          ),
                          BookingData(
                              hotel: widget.hotel,
                              selectedOption: widget.selectedOption,
                              totalAmount: widget.totalAmount),
                          SizedBox(height: 8.v),
                          // BuyerInfo(),
                          //   SizedBox(height: 8.v),
                          // FirstTourist(),
                          // SizedBox(height: 8.v),
                          // SecondTourist(),
                          SizedBox(height: 8.v),
                          AddPackage(),
                          SizedBox(height: 8.v),
                          Paid(
                              hotel: widget.hotel,
                              selectedOption: widget.selectedOption,
                              totalAmount: widget.totalAmount),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BookingButton(),
        ),
      ),
    );
  }
}
