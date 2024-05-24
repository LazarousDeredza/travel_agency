import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/product_repo.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/products_list.dart';
import 'package:travel_agency/tax_hiring_module/src/features/core/screens/vehicle/model_product.dart';

class VehicleController extends GetxController {
  static VehicleController get instance => Get.find();

  final _vehicleRepo = Get.put(ProductRespository());
  //get user email and pass to userRepository to fetch user details

//get all cases
  Future<List<Vehicle>> getAllVehicles() async {
    return _vehicleRepo.getAllVehicles();
  }

  //save case

  Future<void> saveProduct(Vehicle productModel) async {
    //snackbar
    Get.snackbar(
      "Please wait",
      "Saving Vehicle",
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(
        Icons.sync_rounded,
        color: Colors.green,
      ),
    );
    await _vehicleRepo.saveVehicle(productModel.toJson()).whenComplete(() {
      print("Vehicle saved successfully ");

      Get.snackbar(
        "Success",
        "Vehicle saved successfully ",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
        icon: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),
      );
      Get.to(() => const ProductListScreen());
    }).catchError((onError) {
      Get.snackbar(
        "Error",
        "Vehicle not saved",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      );
      return onError;
    });
  }

  // updateRecord(UserModel user) async {
  //   Get.snackbar(
  //     "Please wait",
  //     "Updating user details",
  //     snackPosition: SnackPosition.BOTTOM,
  //     icon: Icon(
  //       Icons.sync_rounded,
  //       color: Colors.green,
  //     ),
  //   );
  //   await _caseRepo.updateUserRecord(user);
  // }
}
