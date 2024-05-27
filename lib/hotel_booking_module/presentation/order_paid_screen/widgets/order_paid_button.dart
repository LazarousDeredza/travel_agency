import 'package:flutter/material.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';

class OrderPaidButton extends StatefulWidget {
  const OrderPaidButton({super.key});

  @override
  State<OrderPaidButton> createState() => _OrderPaidButtonState();
}

class _OrderPaidButtonState extends State<OrderPaidButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 28.v),
      decoration: AppDecoration.outlineGray,
      child: ElevatedButton(

        onPressed: () {
          NavigatorService.pushNamed(AppRoutes.hotelScreen);
        },
        child:Text( "Great!"),
      ),
    );
  }
}
