import 'package:flutter/material.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';

class AddPackage extends StatefulWidget {
  const AddPackage({super.key});

  @override
  State<AddPackage> createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
      decoration: AppDecoration.fillWhiteA
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Text(
              "Add an Extra Package",
              style: theme.textTheme.titleLarge,
            ),
          ),
          CustomIconButton(
            height: 32.adaptSize,
            width: 32.adaptSize,
            padding: EdgeInsets.all(4.h),
            decoration: IconButtonStyleHelper.fillPrimaryTL6,
            child: CustomImageView(imagePath: ImageConstant.imgFrame609),
          ),
        ],
      ),
    );
  }
}
