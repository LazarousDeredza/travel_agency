// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_agency/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/view_image.dart';
import 'package:travel_agency/vacation_module/views/widgets/details_heading_description.dart';
import 'package:travel_agency/vacation_module/views/widgets/violetButton.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:velocity_x/velocity_x.dart';

class DetailsScreen extends StatefulWidget {
  final Map detailsData;
  const DetailsScreen({super.key, required this.detailsData});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var authCredential = firebaseAuth.currentUser;

  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show slider
                    // VxSwiper.builder(
                    //   autoPlay: true,
                    //   enlargeCenterPage: true,
                    //   height: 300,
                    //   aspectRatio: 16 / 9,
                    //   viewportFraction: 1.0,
                    //   itemCount: widget.detailsData['list_images'].length,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(top:20.0),
                    //       child: CachedNetworkImage(
                    //                         imageUrl:widget.detailsData['list_images'][0],
                    //         width: double.infinity,
                    //         fit: BoxFit.cover,
                    //                         filterQuality: FilterQuality.high,
                    //                         placeholder: (context, url) => const Center(
                    //                           child: CircularProgressIndicator(
                    //                             color: Colors.blue,
                    //                           ),
                    //                         ),
                    //                         errorWidget: (context, url, error) => const Icon(Icons.error),
                    //                       ),
                    //     );
                    //   },
                    // ),
                   
                   Builder(
                     builder: (context) {

 //list of image urls

                      final pImages =widget.detailsData['list_images'];

                      List<CarouselItem> itemList = [];

                      List<String>? productImages;
                      if (pImages is List<dynamic>) {
                        productImages = pImages.cast<String>().toList();

                        for (var element in productImages) {
                          print(element);

                          CarouselItem item = CarouselItem(
                            image: NetworkImage(
                              element,
                            ),
                            boxDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                                colors: [
                                  const Color.fromARGB(255, 3, 105, 28)
                                      .withOpacity(1),
                                  Colors.black.withOpacity(.3),
                                ],
                                stops: const [0.0, 1.0],
                              ),
                            ),
                            title: "Travel Agency",
                            titleTextStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            leftSubtitle:
                                'Book your slot',
                            rightSubtitle: DateTime.now().toString(),
                            rightSubtitleTextStyle: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 236, 234, 234),
                            ),
                            onImageTap: (i) {
                              print('$i image tapped');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyImageWidget(imageUrl: element,),
                                ),
                              );
                            },
                          );

                          itemList.add(item);
                        }
                      }

                      return 
                            CustomCarouselSlider(
                              items: itemList,
                              height: 300,
                              subHeight: 50,
                              width: MediaQuery.of(context).size.width * .9,
                              autoplay: true,
                              animationDuration: const Duration(seconds: 3),
                              showText: true,
                            );
                          
                        
                   

                       
                     }
                   ),
                   
                    // CarouselSlider(
                    //   options: CarouselOptions(
                    //     autoPlay: true,
                    //     enlargeCenterPage: true,
                    //     height: 300,
                    //     aspectRatio: 16 / 9,
                    //     viewportFraction: 1.0,
                    //   ),
                    //   items: widget.detailsData['list_images'].map((image) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(top: 20.0),
                    //       child: CachedNetworkImage(
                    //         imageUrl: image,
                    //         width: double.infinity,
                    //         fit: BoxFit.cover,
                    //         filterQuality: FilterQuality.high,
                    //         placeholder: (context, url) => const Center(
                    //           child: CircularProgressIndicator(
                    //             color: Colors.blue,
                    //           ),
                    //         ),
                    //         errorWidget: (context, url, error) =>
                    //             const Icon(Icons.error),
                    //       ),
                    //     );
                    //   }),
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 10.0, right: 10.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.detailsData['list_destination'].toString(),
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$ ${widget.detailsData['list_cost']}',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          detailsHeadingDescription(
                            title: "Description".tr,
                            description: widget.detailsData['list_description'],
                          ),
                          detailsHeadingDescription(
                            title: "Facilites".tr,
                            description: widget.detailsData['list_facilities'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: AppColors.scaffoldColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            return VioletButton(
                              isLoading: isLoading.value,
                              title: "Book This Package".tr,
                              onAction: () async {
                                print("........ " +
                                    widget.detailsData.toString());
                                isLoading(true);
                                await BookTravel(widget.detailsData);
                                isLoading(false);
                                //Get.back();
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.detailsData['list_owner_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(
                                      "tel: ${widget.detailsData['list_phone']}"),
                                );
                              },
                              icon: Icon(Icons.call_outlined),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            IconButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(
                                      "sms:${widget.detailsData['list_phone']}"),
                                );
                              },
                              icon: Icon(Icons.message_outlined),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BookTravel(Map detailsData) {
    //  Razorpay razorpay = Razorpay();
    //                       var options = {
    //                         'key': 'rzp_test_7wgJ3Fl2rDfjid',
    //                         'amount': (totalAmount * 100).toInt(),
    //                         'name': 'Foodie Delight Order',
    //                         'currency': 'USD',
    //                         'description':
    //                             "${_userModel.name}'s Payment for order #$orderID",
    //                         'retry': {
    //                           'enabled': true,
    //                           'max_count': 1,
    //                         },
    //                         'send_sms_hash': true,
    //                         'prefill': {
    //                           'contact': _userModel.phoneNo,
    //                           'email': _userModel.email,
    //                         },
    //                         'external': {
    //                           'wallets': ['paytm']
    //                         }
    //                       };
    //                       razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
    //                           handlePaymentErrorResponse);
    //                       razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
    //                           handlePaymentSuccessResponse);
    //                       razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
    //                           handleExternalWalletSelected);
    //                       razorpay.open(options);
  }
}
