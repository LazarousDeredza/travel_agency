// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/home/home.dart';
import 'package:travel_agency/tax_hiring_module/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:travel_agency/tax_hiring_module/src/repository/authentication_repository/authentication_repository.dart';
import '../../../constant/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

     Get.put(AuthenticationRepository());
    Future.delayed(const Duration(seconds: 5), () {
      // ! ---To go to the next screen and cancel all previous routes (Get.to)
      firebaseAuth.authStateChanges().listen((event) {
        if (event == null && mounted) {
          Get.to(() => WelcomeScreen());
        } else {
         // Get.to(() => VacationHomeScreen());
         Get.to(() => MainHomeScreen());  
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/logo/logo.png",
                height: 250.h,
                width: 250.h,
              ),
            ),
            CircularProgressIndicator(color: AppColors.splashScreenTextColor),
          ],
        ),
      ),
    );
  }
}