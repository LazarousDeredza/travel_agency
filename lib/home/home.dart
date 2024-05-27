import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_agency/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:travel_agency/flight_booking_module/home_screen.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/hotel_home_screen.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/hotel_screen.dart';
import 'package:travel_agency/main.dart';
import 'package:travel_agency/tax_hiring_module/src/constants/image_strings.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/dashboard/dashboard.dart';
import 'package:travel_agency/vacation_module/services/firestore_services.dart';
import 'package:travel_agency/vacation_module/views/screens/vacation_home_screen.dart';
import 'package:travel_agency/vacation_module/views/widgets/nav_home_categories.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with TickerProviderStateMixin {
  final List _carouselImages = [
    'assets/carouseimage/cover-one.jpg',
    'assets/carouseimage/cover-two.jpg',
    tFlight1,
    'assets/carouseimage/cover-four.jpg',
    tHotel1
  ];

  final RxInt _currentIndex = 0.obs;

  Future _exitDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure to close this app?"),
          content: Row(
            children: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text("No"),
              ),
              SizedBox(
                width: 20.w,
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Yes"),
              ),
            ],
          ),
        );
      },
    );
  }

  late final AnimationController _colorAnimationController;
  late final Animation<Color?> _colorAnimation;
  late final Animation<Color?> _colorAnimation1;
  late final Animation<Color?> _colorAnimation2;
  late final Animation<Color?> _colorAnimation3;

  @override
  void initState() {
    super.initState();

    _colorAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _colorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 3, 84, 151),
      end: Color.fromARGB(255, 6, 206, 39),
    ).animate(_colorAnimationController);

    _colorAnimation1 = ColorTween(
      begin: Color.fromARGB(255, 126, 0, 230),
      end: Color.fromARGB(255, 192, 13, 138),
    ).animate(_colorAnimationController);

    _colorAnimation2 = ColorTween(
      begin: Color.fromARGB(255, 234, 93, 0),
      end: Color.fromARGB(255, 24, 3, 141),
    ).animate(_colorAnimationController);

    _colorAnimation3 = ColorTween(
      begin: Color.fromARGB(255, 104, 17, 69),
      end: Color.fromARGB(255, 32, 188, 231),
    ).animate(_colorAnimationController);
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _exitDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // !-----------------CarouselSlider---------------------
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: mq.height / 2.5,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _currentIndex.value = val;
                        });
                      },
                    ),
                    items: _carouselImages.map((image) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 5.h),
              Obx(
                () => DotsIndicator(
                  dotsCount:
                      _carouselImages.length == 0 ? 1 : _carouselImages.length,
                  position: _currentIndex.value.toInt(),
                ),
              ),
              // !---------------------All Package--------------
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _colorAnimation,
                        builder: (context, child) {
                          return Text.rich(
                            TextSpan(
                              children: "H"
                                  .split('')
                                  .map((char) => TextSpan(
                                        text: char,
                                        style: TextStyle(
                                          color: _colorAnimation.value,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: _colorAnimation1,
                        builder: (context, child) {
                          return Text.rich(
                            TextSpan(
                              children: "o"
                                  .split('')
                                  .map((char) => TextSpan(
                                        text: char,
                                        style: TextStyle(
                                          color: _colorAnimation1.value,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: _colorAnimation2,
                        builder: (context, child) {
                          return Text.rich(
                            TextSpan(
                              children: "m"
                                  .split('')
                                  .map((char) => TextSpan(
                                        text: char,
                                        style: TextStyle(
                                          color: _colorAnimation2.value,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: _colorAnimation3,
                        builder: (context, child) {
                          return Text.rich(
                            TextSpan(
                              children: "e"
                                  .split('')
                                  .map((char) => TextSpan(
                                        text: char,
                                        style: TextStyle(
                                          color: _colorAnimation3.value,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2, 2),
                                              blurRadius: 2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.blue.withOpacity(0.5),
                thickness: 1.0,
              ),
              SizedBox(height: 10.h),

              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Vacational
                    GestureDetector(
                      onTap: () {
                        Get.to(() => VacationHomeScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.7),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/carouseimage/cover-one.jpg",
                                width: mq.width / 2.5,
                                height: mq.height / 7,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Visit Places",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Tax Hiring Module
                    GestureDetector(
                      onTap: () {
                        Get.to(() => TaxHome());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.7),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                // passengerVh,
                                tTaxi,
                                height: mq.height / 7,
                                width: mq.width / 2.5,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Taxi Hiring",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Flight Booking Module

                    GestureDetector(
                      onTap: () {
                        Get.to(() => FlightBookingHomeScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.7),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                tFlight2,
                                width: mq.width / 2.5,
                                height: mq.height / 7,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Flight Booking",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Hotel Booking Module
                    GestureDetector(
                      onTap: () {
                        Get.to(() => HotelHomeScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.7),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                tHotel3,
                                width: mq.width / 2.5,
                                height: mq.height / 7,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Hotel Booking",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
