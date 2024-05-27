import 'package:flutter/material.dart';
import 'package:travel_agency/hotel_booking_module/core/app_export.dart';
import 'package:travel_agency/hotel_booking_module/presentation/hotel_screen/widgets/points_widget.dart';

import '../models/peculiarities_model.dart';
import '../notifier/hotel_notifier.dart';
import 'peculiarities_widget.dart';

class About extends StatefulWidget {

  final Hotel hotel;
  const About({required this.hotel, super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return  Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 15.v,
            ),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About the hotel",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 15.v),
               
                // Consumer(
                //   builder: (context, ref, _) {
                //     return Wrap(
                //       runSpacing: 8.v,
                //       spacing: 8.h,
                //       children: List<Widget>.generate(
                //         ref
                //                 .watch(hotelNotifier)
                //                 .hotelModelObj
                //                 ?.aboutHotelList
                //                 .length ??
                //             0,
                //         (index) {
                //           PeculiaritiesModel model = ref
                //                   .watch(hotelNotifier)
                //                   .hotelModelObj
                //                   ?.aboutHotelList[index] ??
                //               PeculiaritiesModel();

                //           return Peculiarities(
                //             model,
                //             onSelectedChipView1: (value) {
                //               ref
                //                   .read(hotelNotifier.notifier)
                //                   .onSelectedChipView1(index, value);
                //             },
                //           );
                //         },
                //       ),
                //     );
                //   },
                // ),
                // SizedBox(height: 11.v),
                SizedBox(
                  width: 340.h,
                  child: Text(
                    widget.hotel.aboutTheHotel.description,
                    maxLines: 6,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style:
                        CustomTextStyles.bodyLargeSecondaryContainer_1.copyWith(
                      height: 1.20,
                    ),
                  ),
                ),
 SizedBox(height: 8.v),
                 Center(
                  child: Text("Peculiarities",style: TextStyle(fontWeight: FontWeight.bold),),

                ),
                 SizedBox(height: 8.v),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.hotel.aboutTheHotel.peculiarities.length,
                    itemBuilder: (context, index) {
                      
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(onPressed: (){}, child: Text(
                            widget.hotel.aboutTheHotel.peculiarities[index]
                          ),),
                         SizedBox(width: 10,)
                        ],
                      );
                    },
                  
                  ),
                ),

                SizedBox(height: 13.v),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.h,
                    vertical: 14.v,
                  ),
                  decoration: AppDecoration.fillGray50.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder15,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Points(
                        checkmark: ImageConstant.imgSettings,
                        titleMediumOnSecondaryContainer: "Facilities",
                        titleSmall: "Essentials",
                      ),
                      SizedBox(height: 9.v),
                      Divider(
                        indent: 38.h,
                      ),
                      SizedBox(height: 8.v),
                      Points(
                        checkmark: ImageConstant.imgCheckmark,
                        titleMediumOnSecondaryContainer: "What's included",
                        titleSmall: "Essentials",
                      ),
                      SizedBox(height: 9.v),
                      Divider(
                        indent: 38.h,
                      ),
                      SizedBox(height: 8.v),
                      Points(
                        checkmark: ImageConstant.imgClose,
                        titleMediumOnSecondaryContainer: "What's not included",
                        titleSmall: "Essentials",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      
    

}
