import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:travel_agency/hotel_booking_module/core/app_export.dart';

import '../notifier/hotel_notifier.dart';
import 'basic_data.dart';

class SliderCarousel extends StatefulWidget {
   final Hotel hotel;
  const SliderCarousel(  {required this.hotel,super.key});

  @override
  State<SliderCarousel> createState() => _SliderCarouselState();
}

class _SliderCarouselState extends State<SliderCarousel> {

  @override
  Widget build(BuildContext context) {

  final List<String> imagesList = widget.hotel.imageUrls;


    return Container(
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 257.v,
            width: 343.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 257.v,
                        initialPage: 0,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (
                          index,
                          reason,
                        ) {
                          ref.watch(hotelNotifier).sliderIndex = index;
                        },
                      ),
                      itemCount: imagesList.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  imagesList[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer(
                    builder: (context, ref, _) {
                      return Container(
                        height: 17.v,
                        margin: EdgeInsets.only(bottom: 8.v),
                        child: AnimatedSmoothIndicator(
                          activeIndex: ref.watch(hotelNotifier).sliderIndex,
                          count: ref
                                  .watch(hotelNotifier)
                                  .hotelModelObj
                                  ?.sliderList
                                  .length ??
                              0,
                          axisDirection: Axis.horizontal,
                          effect: ScrollingDotsEffect(
                            spacing: 5,
                            activeDotColor: theme.colorScheme.secondaryContainer
                                .withOpacity(1),
                            dotColor: theme.colorScheme.secondaryContainer
                                .withOpacity(0.22),
                            dotHeight: 7.v,
                            dotWidth: 7.h,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.v),
          BasicData(hotel: widget.hotel,),
        ],
      ),
    );
  }
}
