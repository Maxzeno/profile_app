import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:profile/app/login.dart';
import 'package:profile/src/components/button/my_elevatedbutton.dart';
import 'package:profile/src/components/text/row_text.dart';
import 'package:profile/src/utils/constants.dart';
import 'package:profile/src/utils/helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //=========================== INITIAL STATE AND DISPOSE ====================================\\
  @override
  void initState() {
    super.initState();
  }

  //=========================== ALL VARIABBLES ====================================\\

  //=========================== FUNCTIONS ====================================\\

  void _logout() {
    removeToken();
    Get.off(
      () => const Login(),
      routeName: 'Login',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kWhiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          height: media.height,
          width: media.width,
          padding: const EdgeInsets.only(
            top: kDefaultPadding / 2,
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kSizedBox,
                  Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/avatar/avatar-image.jpg',
                        width: media.width - 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  kSizedBox,
                  kSizedBox,
                  kSizedBox,
                  const RowText(
                    left: 'Username',
                    right: 'Emmanuel Nwaegunwa',
                  ),
                  const RowText(
                    left: 'Email',
                    right: "emmanuelnwaegunwa@gmail.com",
                  ),
                  const RowText(
                    left: 'Phone',
                    right: "+2349077745730",
                  ),
                  const RowText(
                    left: 'Address',
                    right: "House 35 My city estate Lekki lagos",
                  ),
                  MyElevatedButton(
                    title: "Logout",
                    onPressed: _logout,
                    isLoading: false,
                  ),
                  kSizedBox,
                ],
              ),
              kSizedBox,
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
