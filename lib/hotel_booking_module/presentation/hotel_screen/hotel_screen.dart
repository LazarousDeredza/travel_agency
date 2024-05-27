import 'package:flutter/material.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/widgets/hotel_button.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/widgets/hotel_appbar.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/widgets/slider_carousel.dart';

import 'widgets/about_widget.dart';
import 'package:travel_agency/hotel_booking_module/core/app_export.dart';

class HotelScreen extends ConsumerStatefulWidget {

  final Hotel hotel;
  const HotelScreen( {required this.hotel,super.key});

  @override
  HotelScreenState createState() => HotelScreenState();
}

class HotelScreenState extends ConsumerState<HotelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HotelAppbar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  SliderCarousel(hotel: widget.hotel,),
                  SizedBox(height: 23.v),
                  About(hotel: widget.hotel,),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: HotelButton(hotel: widget.hotel,),
      ),
    );
  }
}
