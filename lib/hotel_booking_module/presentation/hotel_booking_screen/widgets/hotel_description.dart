import 'package:flutter/material.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';

class HotelDescription extends StatefulWidget {
  final Hotel hotel;
  const HotelDescription({required this.hotel, super.key});

  @override
  State<HotelDescription> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HotelDescription> {
  @override
  Widget build(BuildContext context) {
    return  Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
              decoration: AppDecoration.fillWhiteA
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 3.v),
                    decoration: AppDecoration.fillAmberA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgStar2215x15,
                          height: 15.adaptSize,
                          width: 15.adaptSize,
                          radius: BorderRadius.circular(1.h),
                          margin: EdgeInsets.symmetric(vertical: 3.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 2.h,
                            top: 2.v,
                          ),
                          child: Text(
                            widget.hotel.rating.toString(),
                            style: CustomTextStyles.titleMediumAmberA700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.h,
                            top: 2.v,
                          ),
                          child: Text(
                            widget.hotel.ratingName,
                            style: CustomTextStyles.titleMediumAmberA700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9.v),
                  Text(
                    widget.hotel.name,
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 3.v),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(appTheme.whiteA700),
                    ),
                    onPressed: () {},
                    child: Text(
                      widget.hotel.address,
                      style: CustomTextStyles.titleSmallPrimary,
                    ),
                  ),
                ],
              ),
            );
          }
       
  
}
