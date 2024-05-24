import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/tax_hiring_module/src/features/authentication/models/user_model.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/model_product.dart';

/* 
Todo: to perform all database operations here
 */
class ProductRespository extends GetxController {
  static ProductRespository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

//fetch user details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("users").where("email", isEqualTo: email).get();

    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    // Continue with further processing
    print("User found");
  
    return userData;
  }

  // //fetch all users
  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _db.collection("users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<List<Vehicle>> getAllVehicles() async {
    final snapshot = await _db.collection("vehicles").get();
    final data = snapshot.docs.map((e) => Vehicle.fromSnapshot(e)).toList();
    return data;
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

  Future<void> saveVehicle(Map<String, dynamic> json) async {
    await _db.collection("vehicles").add(json);
  }
}
