import 'package:flutter/material.dart';
import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import 'package:intl/intl.dart';

class BasicData extends StatefulWidget {

  final Hotel hotel;
  const BasicData({required this.hotel, super.key});

  @override
  State<BasicData> createState() => _BasicDataState();
}

class _BasicDataState extends State<BasicData> {
  @override
  Widget build(BuildContext context) {
     NumberFormat formatter = NumberFormat('#,###');
   
            return Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 3.v,
                    ),
                    decoration: AppDecoration.fillAmberA.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                    ),
                    child: Row(
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
                  Center(
                    child: Text(
                       widget.hotel.name,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 6.v),
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
                  SizedBox(height: 15.v),
                  Row(
                    children: [
                      Text(
                        '\$ ${formatter.format(widget.hotel.minimalPrice.toInt())}'
                                .replaceAll(',', ' ')                           ,
                        style: theme.textTheme.headlineLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.h,
                          top: 14.v,
                        ),
                        child: Text(
                          "Minimum Price",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          
        
  }
}
