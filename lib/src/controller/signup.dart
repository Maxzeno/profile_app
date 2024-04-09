import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:profile/src/components/snackbar/snackbar.dart';
import 'package:profile/src/controller/login.dart';
import 'package:profile/src/utils/constants.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find<SignupController>();

  var isLoading = false.obs;
  var isPWSuccess = false.obs;
  var showPassword = false.obs;

  void setShowPassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  void setPWSuccess(bool value) {
    isPWSuccess.value = value;
    update();
  }

  Future signup(
      {required String username,
      required String password,
      required String email,
      required String phone,
      required String address}) async {
    isLoading.value = true;
    update();

    var url = "$baseURL/register";

    final body = jsonEncode({
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'address': address,
      'image': "",
    });

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        await LoginController.instance
            .login(username: username, password: password);
        successSnackbar("Signup Successful");
        setShowPassword();
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
