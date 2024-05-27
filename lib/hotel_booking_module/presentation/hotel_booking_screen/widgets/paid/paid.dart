import 'package:flutter/material.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_booking_screen/widgets/paid/price.dart';

class Paid extends StatefulWidget {

final Hotel hotel;
final int totalAmount;
final String selectedOption;

  const Paid({required this.hotel,required this.totalAmount,required this.selectedOption,super.key});

  @override
  State<Paid> createState() => _PaidState();
}

class _PaidState extends State<Paid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
      decoration: AppDecoration.fillWhiteA
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Price(
            titleText: "Initial",
            priceText:"\$" +widget.hotel.minimalPrice.toString(),
          ),
          SizedBox(height: 13.v),
          Price(
            titleText: "Extra",
            priceText:"\$" + ((widget.totalAmount-widget.hotel.minimalPrice)-3).toString(),
          ),
          SizedBox(height: 13.v),
          Price(
            titleText: "Additional",
            priceText: "\$3",
          ),
          SizedBox(height: 13.v),
          Price(
            titleText: "To pay",
            priceText: "\$" +widget.totalAmount.toString(),
          ),
        ],
      ),
    );
  }
}
