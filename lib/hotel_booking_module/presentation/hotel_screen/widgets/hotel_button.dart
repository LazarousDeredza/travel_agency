import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_colors.dart';
import 'package:travel_agency/hotel_booking_module/core/app_export.dart';

import '../../../widgets/custom_elevated_button.dart';

class HotelButton extends StatefulWidget {
final Hotel hotel;

  const HotelButton({required this.hotel, super.key});

  @override
  State<HotelButton> createState() => _HotelButtonState();
}

class _HotelButtonState extends State<HotelButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16.h,
        right: 16.h,
        bottom: 28.v,
      ),
     // decoration: AppDecoration.fillAmberA,
      child: ElevatedButton(
       
       
        onPressed: () {
         Get.to(()=> HotelRoomScreen( hotel: widget.hotel,));
        }, 
        child: const Text("Proceed"),
      ),
    );
  }
}
