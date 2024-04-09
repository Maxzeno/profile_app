import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profile/app/login.dart';
import 'package:profile/src/components/snackbar/snackbar.dart';
import 'package:profile/src/models/user_model.dart';
import 'package:profile/src/utils/constants.dart';
import 'package:profile/src/utils/helper.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find<UserController>();

  var isLoading = false.obs;
  var user = UserModel.fromJson(null).obs;

  Future getUser() async {
    isLoading.value = true;

    var url = "$baseURL/profile";
    String? token = getToken();
    if (token == null) {
      Get.off(
        () => const Login(),
        routeName: 'Login',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.rightToLeft,
      );
      isLoading.value = false;
      return;
    }
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        user.value = modelUser(jsonDecode(response.body));
      } else {
        failedSnackbar(response.body);
      }
    } catch (e) {
      failedSnackbar("Something went wrong");
    }
    isLoading.value = false;
  }
}
