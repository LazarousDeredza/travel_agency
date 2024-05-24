import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_agency/tax_hiring_module/src/repository/authentication_repository/authentication_repository.dart';
import 'package:travel_agency/tax_hiring_module/src/repository/user_repository/user_repository.dart';

import '../models/user_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNo = TextEditingController();
  final lastName = TextEditingController();

  final userRepo = Get.put(UserRespository());

  Future<void> createUser(String email, String password, UserModel user) async {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password, user);
  }

  Future<void> forgotPassword(String email) async {
    AuthenticationRepository.instance.sendResetLink(email);
  }
}
