import 'package:flutter/material.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import '../../../../widgets/custom_floating_text_field.dart';
import '../../notifier/hotel_booking_notifier.dart';

class BuyerPhone extends ConsumerStatefulWidget {
  const BuyerPhone({super.key});

  @override
  _BuyerPhoneState createState() => _BuyerPhoneState();
}

class _BuyerPhoneState extends ConsumerState<BuyerPhone> {
  @override
  void dispose() {
   // ref.watch(hotelBookingNotifier).phoneNumberController.dispose();
    //ref.watch(hotelBookingNotifier).phoneNumberFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return CustomFloatingTextField(
        textInputType: TextInputType.phone,
        controller: ref.watch(hotelBookingNotifier).phoneNumberController,
        focusNode: ref.watch(hotelBookingNotifier).phoneNumberFocusNode,
        labelText: "Phone number",
        labelStyle: CustomTextStyles.bodyLargeOnPrimary,
        hintText: "+263 xxx xxx xxx",
        autofocus: false,
      );
    });
  }
}
