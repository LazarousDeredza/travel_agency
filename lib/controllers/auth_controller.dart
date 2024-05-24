// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/constant.dart';
import 'package:travel_agency/home/home.dart';
import 'package:travel_agency/models/user_model.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/services/helper/helper_function.dart';
import 'package:travel_agency/vacation_module/views/auth/login_screen.dart';
import 'package:travel_agency/vacation_module/views/screens/vacation_home_screen.dart';

class AuthController extends GetxController {
  //for button loading indicator
  var isLoading = false.obs;

  Future userRegistration({
    required String name,
    required String email,
    required String password,
    required String number,
    required String address, required String firstName, required String lastname,
  }) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          firstName.isNotEmpty&&
          lastname.isNotEmpty&&
          password.isNotEmpty &&
          number.isNotEmpty &&
          address.isNotEmpty) {
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        var authCredential = userCredential.user;
        if (authCredential!.uid.isNotEmpty) {
          Get.snackbar("Successful", "Registration Successfull");
          Get.to(() => MainHomeScreen());
        } else {
          Get.snackbar("Error", "Something is wrong!",
              backgroundColor: Colors.red, colorText: Colors.white);
        }

        String level = "user";
        if (email.trim().toLowerCase() == "gzutravelagency@gmail.com"||email.trim().toLowerCase() == "ninja.ld49@gmail.com") {
          // Set user level to admin
          level = "admin";
        }

        final time = DateTime.now().millisecondsSinceEpoch.toString();
        UserModel userModel = UserModel(
            name: name,
            uid: userCredential.user!.uid,
            email: email,
            phoneNumber: number,
            address: address,

            
            id: userCredential.user!.uid,
            firstName: firstName.trim(),
            lastName:lastname.trim(),
            password: password.trim(),
            level: level,
            groups: [],
            instGroups: [],
            image: "",
            createdAt: time,
            about: 'Hey there! I am using Travel Agency App',
            isOnline: false,
            lastActive: time,
            pushToken: '');
        //save user info in firebase
        await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());


 await CommunityGroupHelperFunctions.saveUserLoggedInStatus(true);
      await CommunityGroupHelperFunctions.saveUserEmailSF(email);
      await CommunityGroupHelperFunctions.saveUserNameSF(name);

      } else {
        Get.snackbar("Error", "Please enter all the field!",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Error", "The password provided is too weak.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The account already exists for that email.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (e.code == 'invalid-email') {
        Get.snackbar("Error", "Please write right email",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Error is: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  //!-------------------for user login----------
  Future userLogin({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        var authCredential = userCredential.user;
        if (authCredential!.uid.isNotEmpty) {
          Get.snackbar("Successful", "successfully Login");
          Get.to(() => MainHomeScreen());
        } else {
          Get.snackbar("Error", "Something is wrong!",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Please enter all the field!",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "No user found for that email.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password provided for that user.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Error is: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  //for logout
  signOut() async {
    await firebaseAuth.signOut();
    Fluttertoast.showToast(msg: 'Log out');
    Get.to(() => SignInScreen());
  }
}
