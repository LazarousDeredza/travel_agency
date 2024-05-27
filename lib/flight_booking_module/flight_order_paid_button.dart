import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/flight_booking_module/home_screen.dart';
import 'package:travel_agency/home/home.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/hotel_home_screen.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/details/screens/home.dart';

class FlightOrderPaidButton extends StatefulWidget {
  const FlightOrderPaidButton({super.key});

  @override
  State<FlightOrderPaidButton> createState() => _FlightOrderPaidButtonState();
}

class _FlightOrderPaidButtonState extends State<FlightOrderPaidButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 28.v),
      decoration: AppDecoration.outlineGray,
      child: ElevatedButton(

        onPressed: () {
          Get.to(()=>MainHomeScreen());
        },
        child:Text( "Great!"),
      ),
    );
  }
}
