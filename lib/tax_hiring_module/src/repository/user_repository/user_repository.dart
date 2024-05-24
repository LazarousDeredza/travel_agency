import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/constant/app_strings.dart';
import 'package:travel_agency/tax_hiring_module/src/features/authentication/models/user_model.dart';

/* 
Todo: to perform all database operations here
 */
class UserRespository extends GetxController {
  static UserRespository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

//fetch user details
  Future<UserModel> getUserDetails(String email) async {
    String uid = firebaseAuth.currentUser!.uid;
    print("UID: " + uid);
    print("Getting user Data .....");

    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").doc(uid).get();

        print(snapshot.data());
    final userData = UserModel.fromSnapshot(snapshot);

    // Continue with further processing
    print("User found");

    return userData;
  }

  // //fetch all users
  // Future<List<UserModel>> getAllUsers() async {
  //   final snapshot = await _db.collection("users").get();
  //   final userData =
  //       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  //   return userData;
  // }

  Future<List<UserModel>> getAllUsers() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    print("Current User =$uid");
    final snapshot = await _db.collection("users").get();
    final userData = snapshot.docs
        .map((e) => UserModel.fromSnapshot(e))
        .where((user) => user.id != uid)
        .toList();
    return userData;
  }

  Future<List<UserModel>> getAllAdmins() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    print("Current User =$uid");
    final snapshot = await _db.collection("users").get();
    final userData = snapshot.docs
        .map((e) => UserModel.fromSnapshot(e))
        .where((user) => user.id != uid)
        .where((user) => user.level == "admin")
        .toList();
    return userData;
  }

  //update user details
  Future<void> updateUserRecord(UserModel user) async {
    print(user.id);
    final snapshot =
        await _db.collection("users").doc(user.id).update(user.toJson());

    Get.snackbar(
      "Success",
      "User updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      ),
    );

    return snapshot;
  }
}
