import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profile/app/profile.dart';
import 'package:profile/src/components/snackbar/snackbar.dart';
import 'package:profile/src/utils/constants.dart';
import 'package:profile/src/utils/helper.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();

  var isLoading = false.obs;
  var showPassword = false.obs;

  void setShowPassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  Future login({required String username, required String password}) async {
    isLoading.value = true;
    update();

    var url = "$baseURL/login";

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        successSnackbar("Login Successful");
        await setToken(jsonDecode(response.body)['token']);
        setShowPassword();
        Get.off(
          () => const Profile(),
          routeName: 'Profile',
          duration: const Duration(milliseconds: 300),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          popGesture: true,
          transition: Transition.rightToLeft,
        );
      } else {
        failedSnackbar(response.body);
      }
    } catch (e) {
      if (e is TimeoutException) {
        failedSnackbar("Please check your internet");
      } else {
        failedSnackbar("Something went wrong");
      }
    }
    isLoading.value = false;
    update();
  }
}
