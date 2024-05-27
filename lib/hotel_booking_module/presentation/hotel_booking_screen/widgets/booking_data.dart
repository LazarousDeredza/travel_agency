import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travel_agency/hotel_booking_module/core/app_export.dart';

class BookingData extends StatefulWidget {


final Hotel hotel;
final int totalAmount;
final String selectedOption;

  const BookingData({required this.hotel,required this.totalAmount,required this.selectedOption,super.key});

  @override
  State<BookingData> createState() => _BookingDataState();
}

class _BookingDataState extends State<BookingData> {
  @override
  Widget build(BuildContext context) {
    return  Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
              decoration: AppDecoration.fillWhiteA
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 77.h),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.v),
                          child: Text(
                            "Rated",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 76.h),
                          child: Text(
                            "Top Star",
                            style: CustomTextStyles.bodyLargeSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.v),
                  Padding(
                    padding: EdgeInsets.only(right: 89.h),
                    child: Row(
                      children: [
                        Text(
                          "Country city",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 39.h),
                          child: Text(
                            "Zimbabwe",
                            style: CustomTextStyles.bodyLargeSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                  SizedBox(height: 13.v),
                 
                  SizedBox(height: 15.v),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.v),
                          child: Text(
                            "Hotel",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Text(
                          widget.hotel.name,
                          style: CustomTextStyles.bodyLargeSecondaryContainer,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13.v),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1.v, bottom: 19.v),
                          child: Text(
                            "Selected Package",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Container(
                          width: 100.h,
                          margin: EdgeInsets.only(left: 40.h),
                          child: Text(
                            widget.selectedOption,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodyLargeSecondaryContainer
                                .copyWith(height: 1.20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13.v),
                  Row(
                    children: [
                      Text("Nutrition", style: theme.textTheme.bodyLarge),
                      Padding(
                        padding: EdgeInsets.only(left: 79.h),
                        child: Text(
                          "All inclusive",
                          style: CustomTextStyles.bodyLargeSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
     
  
}
