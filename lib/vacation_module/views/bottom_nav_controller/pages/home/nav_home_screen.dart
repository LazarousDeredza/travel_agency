// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_agency/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:travel_agency/vacation_module/services/firestore_services.dart';
import 'package:travel_agency/vacation_module/views/widgets/nav_home_categories.dart';

import 'details_screen.dart';
import 'all_package_screen.dart';
import 'luxury_all_screen.dart';
import 'economy_all_screen.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({super.key});

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  final List _carouselImages = [
    'assets/carouseimage/cover-one.jpg',
    'assets/carouseimage/cover-two.jpg',
    'assets/carouseimage/cover-three.jpg',
    'assets/carouseimage/cover-four.jpg',
    'assets/carouseimage/cover-five.jpg',
  ];

  final RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // !-----------------CarouselSlider---------------------
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 180.h,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(() {
                        _currentIndex.value = val;
                      });
                    },
                  ),
                  items: _carouselImages.map((image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 5.h),
            Obx(
              () => DotsIndicator(
                dotsCount:
                    _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _currentIndex.value.toInt(),
              ),
            ),
            // !---------------------All Package--------------
            navHomeCategories(
              "All Package",
              () => Get.to(
                () => SeeAllScreen(
                  compare: "phone",
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 180.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getForYouPackage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.hasData) {
                      List<Map> items = parseData(snapshot.data);
                      return forYou(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Text("");
                  },
                ),
              ),
            ),

            SizedBox(height: 15.h),
            // !---------------------Top Place--------------
            navHomeCategories(
              "Top Place",
              () => Get.to(
                () => SeeAllScreen(
                  compare: "cost",
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 80.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getTopPlacePackage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.hasData) {
                      List<Map> items = parseData(snapshot.data);
                      return topPlaces(items);
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            SizedBox(height: 25.h),
            // !---------------------Economy package--------------
            //Economy package
            navHomeCategories(
              "Economy",
              () => Get.to(
                () => EconomyAllScreen(),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 180.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getEconomyPackage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.hasData) {
                      List<Map> items = parseData(snapshot.data);
                      return economyPackage(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Text("");
                  },
                ),
              ),
            ),
            //Luxury package
            SizedBox(height: 25),
            // !---------------------Luxury--------------
            navHomeCategories(
              "Luxury",
              () => Get.to(
                () => LuxuryAllScreen(),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 180.h,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirestoreServices.getLuxuryPackage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    if (snapshot.hasData) {
                      List<Map> items = parseData(snapshot.data);
                      return luxuryPackage(items);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Text("");
                  },
                ),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

List<Map> parseData(QuerySnapshot querySnapshot) {
  List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
  List<Map> listItems = listDocs
      .map((e) => {
            'list_images': e['gallery_img'],
            'list_destination': e['destination'],
            'list_cost': e['cost'],
            'list_description': e['description'],
            'list_facilities': e['facilities'],
            'list_owner_name': e['owner_name'],
            'list_phone': e['phone'],
            'list_date': e['date_time'],
            'list_topPlaces': e['topPlaces'],
            'list_economy': e['economy'],
            'list_luxury': e['topPlaces'],
          })
      .toList();
  return listItems;
}

List<Map> parseData2(QuerySnapshot querySnapshot) {
  List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
  List<Map> listItems = listDocs
      .map((e) => {
            'list_images': e['gallery_img'],
            'list_destination': e['destination'],
            'list_cost': e['cost'],
            'list_total_cost': e['total_cost'],
            'list_description': e['description'],
            'list_facilities': e['facilities'],
            'list_owner_name': e['owner_name'],
            'list_phone': e['phone'],
            'list_date': e['date_time'],
            'list_end_date': e['end_date']
          })
      .toList();
  return listItems;
}

ListView forYou(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 130.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7.r),
                    topRight: Radius.circular(7.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: thisItem['list_images'][0],
                    height: 100.h,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      thisItem['list_destination'].length > 22
                          ? thisItem['list_destination'].substring(0, 22) +
                              '...'
                          : thisItem['list_destination'],
                      style: TextStyle(fontSize: 15.sp),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Text(
                  "\$ ${thisItem['list_cost']}",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ListView topPlaces(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(thisItem['list_images'][0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    },
  );
}

ListView economyPackage(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 130.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7.r),
                    topRight: Radius.circular(7.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: thisItem['list_images'][0],
                    height: 100.h,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      thisItem['list_destination'].length > 22
                          ? thisItem['list_destination'].substring(0, 22) +
                              '...'
                          : thisItem['list_destination'],
                      style: TextStyle(fontSize: 15.sp),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Text(
                  "\$ ${thisItem['list_cost']}",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

ListView luxuryPackage(List<Map<dynamic, dynamic>> items) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (_, index) {
      Map thisItem = items[index];
      return Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: InkWell(
          onTap: () => Get.to(
            () => DetailsScreen(detailsData: thisItem),
          ),
          child: Container(
            width: 130.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Color(0xFfC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(7.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7.r),
                    topRight: Radius.circular(7.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: thisItem['list_images'][0],
                    height: 100.h,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      thisItem['list_destination'].length > 22
                          ? thisItem['list_destination'].substring(0, 22) +
                              '...'
                          : thisItem['list_destination'],
                      style: TextStyle(fontSize: 15.sp),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Text(
                  "\$ ${thisItem['list_cost']}",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
