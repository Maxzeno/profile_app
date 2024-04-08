import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:profile/app/signup.dart';
import 'package:profile/components/snackbar/snackbar.dart';
import 'package:profile/components/theme/app_theme.dart';

void main() {
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
      home: const SignUp(),
    );
  }
}
