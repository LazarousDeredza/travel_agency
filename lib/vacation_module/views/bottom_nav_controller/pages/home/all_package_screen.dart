// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables, unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_agency/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/vacation_module/services/firestore_services.dart';
import 'package:travel_agency/vacation_module/views/bottom_nav_controller/pages/home/nav_home_screen.dart';

import 'details_screen.dart';

class SeeAllScreen extends StatefulWidget {
  var compare;
  SeeAllScreen({super.key, required this.compare});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  //collectionName
  final CollectionReference _refference = firestore.collection('all-data');

  //queryName
  late Future<QuerySnapshot> _futureDataForYour;
  late Future<QuerySnapshot> _futureDataRecentlyAdded;
  late Future<QuerySnapshot> _futureDataTopPlaces;

  @override
  void initState() {
    _futureDataForYour = FirestoreServices.getForYouPackage();
    _futureDataTopPlaces = FirestoreServices.getTopPlacePackage();

    super.initState();
  }

  condition() {
    if (widget.compare == 'phone') {
      return _futureDataForYour;
    } else if (widget.compare == 'cost') {
      return _futureDataTopPlaces;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          "All Package".tr,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: FutureBuilder<QuerySnapshot>(
          future: condition(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (snapshot.hasData) {
              List<Map> items = parseData(snapshot.data);
              return forYouBuildGridview(items);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

GridView forYouBuildGridview(List<Map<dynamic, dynamic>> itemList) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8),
    itemCount: itemList.length,
    itemBuilder: (_, i) {
      Map thisItem = itemList[i];
      return InkWell(
        onTap: () => Get.to(
          () => DetailsScreen(detailsData: thisItem),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[500],
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
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  thisItem['list_destination'],
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color.fromARGB(255, 59, 80, 27),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "\$ ${thisItem['list_cost']}\/day",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}
