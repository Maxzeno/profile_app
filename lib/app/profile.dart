import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profile/app/login.dart';
import 'package:profile/src/components/button/my_elevatedbutton.dart';
import 'package:profile/src/components/loading/loading.dart';
import 'package:profile/src/components/text/row_text.dart';
import 'package:profile/src/controller/user.dart';
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
    // UserController.instance.getUser();
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
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: GetBuilder<UserController>(
              initState: (state) => state.controller?.getUser(),
              builder: (controller) {
                if (controller.isLoading.value) {
                  return const Loading();
                }
                return ListView(
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
                            child: SvgPicture.network(
                              controller.user.value.image,
                              placeholderBuilder: (BuildContext context) =>
                                  const CircularProgressIndicator(
                                color: kMainRed,
                              ),
                              width: media.width - 100,
                            ),
                          ),
                        ),
                        kSizedBox,
                        kSizedBox,
                        kSizedBox,
                        RowText(
                          left: 'Username',
                          right: controller.user.value.username,
                        ),
                        RowText(
                          left: 'Email',
                          right: controller.user.value.email,
                        ),
                        RowText(
                          left: 'Phone',
                          right: controller.user.value.phone,
                        ),
                        RowText(
                          left: 'Address',
                          right: controller.user.value.address,
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
                );
              }),
        ),
      ),
    );
  }
}
