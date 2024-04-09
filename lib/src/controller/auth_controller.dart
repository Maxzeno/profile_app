import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profile/app/profile.dart';
import 'package:profile/src/components/snackbar/snackbar.dart';
import 'package:profile/src/utils/constants.dart';
import 'package:profile/src/utils/helper.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  var isLoading = false.obs;

  Future checkAuth() async {
    isLoading.value = true;

    var url = "$baseURL/profile";
    String? token = getToken();
    if (token == null) {
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
        Get.offAll(
          () => const Profile(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          routeName: "Profile",
          predicate: (route) => false,
          popGesture: false,
          transition: Transition.cupertinoDialog,
        );
      }
    } catch (e) {
      failedSnackbar("Something went wrong");
    }
    isLoading.value = false;
  }
}
