// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_agency/constant/app_colors.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/controllers/auth_controller.dart';
import 'package:travel_agency/vacation_module/services/firestore_services.dart';
import 'package:travel_agency/vacation_module/views/drawer_page/settings/profile_screen.dart';

import '../../auth/login_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  RxBool darkMode = false.obs;

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Settings".tr,
          style: TextStyle(color: AppColors.textColor),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => ProfileScreen()),
            icon: Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () async{
              await firebaseAuth.signOut();
               Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignInScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Logout".tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
            stream: FirestoreServices.getUserInfo(
              uid: firebaseAuth.currentUser!.uid,
            ),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data;
                return ListTile(
                  leading: Icon(Icons.person, size: 50.h),
                  title: Text(data["name"].toString()),
                  subtitle: Text(data['email'].toString()),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              children: [
                Text(
                  "Package".tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreServices.getUserUploadedPackages(
                uid: firebaseAuth.currentUser!.uid,
              ),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) {
                        var data = snapshot.data!.docs[index];
                        return Card(
                                                  color: AppColors.scaffoldColor,
                          child: ListTile(
                            leading:  ClipRRect(
                               borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                              child: Image.network(
                                data['gallery_img'][0],
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            title: Text("${data['destination']}",style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text("\$ ${data['cost']}", style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700)),
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      FirestoreServices.deletePackage(
                                          docId: data.id);
                                      Get.snackbar(
                                          "Successful", "Delete SUccessfully.");
                                      Get.back();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: 10.w),
                                        Text("delete".tr),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}