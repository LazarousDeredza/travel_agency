import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/widgets/hotel_button.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/widgets/hotel_appbar.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/widgets/slider_carousel.dart';

import 'widgets/about_widget.dart';
import 'package:travel_agency/hotel_booking_module/core/app_export.dart';

class HotelHomeScreen extends ConsumerStatefulWidget {
  const HotelHomeScreen({super.key});

  @override
  HotelScreenState createState() => HotelScreenState();
}

class HotelScreenState extends ConsumerState<HotelHomeScreen> {
  late List<Hotel> hotels;

  @override
  void initState() {
    super.initState();

    hotels = fetchHotels();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('#,###');

    return SafeArea(
      child: Scaffold(
        appBar: HotelAppbar(),
        body: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            Hotel hotel = hotels[index];

            print("Hotels length = " + hotels.length.toString());

            return GestureDetector(
              onTap: () {
                Get.to(() => HotelScreen(
                      hotel: hotel,
                    ));
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 20.0, left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 37, 52).withOpacity(0.6),
                  ),
                  child: Column(children: [
                    Image.asset(
                      hotel.imageUrls[0],
                      height: MediaQuery.of(context).size.height/3.3,
                      width: MediaQuery.of(context).size.width/1.2,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 15.v),
                    Center(
                        child: Text(
                      hotel.name,
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: Colors.white),
                    )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgStar22,
                          height: 15.adaptSize,
                          width: 15.adaptSize,
                          radius: BorderRadius.circular(
                            1.h,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 3.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 2.h,
                            top: 2.v,
                          ),
                          child: Text(
                            hotel.rating.toString(),
                            style: CustomTextStyles.titleMediumAmberA700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.h,
                            top: 2.v,
                          ),
                          child: Text(
                            hotel.ratingName,
                            style: CustomTextStyles.titleMediumAmberA700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 9.v),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(appTheme.whiteA700),
                      ),
                      onPressed: () {},
                      child: Text(
                        hotel.address,
                        style: CustomTextStyles.titleSmallPrimary,
                      ),
                    ),
                    SizedBox(height: 15.v),
                    Row(
                      children: [
                        Text(
                          '\$ ${formatter.format(hotel.minimalPrice.toInt())}'
                              .replaceAll(',', ' '),
                          style: theme.textTheme.headlineLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8.h,
                            top: 14.v,
                          ),
                          child: Text(
                            "minimum starting amount",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
