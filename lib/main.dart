import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:profile/app/profile.dart';
import 'package:profile/src/components/snackbar/snackbar.dart';
import 'package:profile/src/components/theme/app_theme.dart';
import 'package:profile/src/controller/auth_controller.dart';
import 'package:profile/src/controller/login.dart';
import 'package:profile/src/controller/signup.dart';
import 'package:profile/src/controller/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  Get.put(UserController());
  Get.put(LoginController());
  Get.put(SignupController());
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Profile App',
      navigatorKey: Get.key,
      scaffoldMessengerKey: SnackBarController.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const Profile(),
    );
  }
}
