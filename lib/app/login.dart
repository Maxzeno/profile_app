import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:profile/app/signup.dart';
import 'package:profile/src/components/button/my_elevatedbutton.dart';
import 'package:profile/src/components/text/form_text.dart';
import 'package:profile/src/components/textformfield/textformfield.dart';
import 'package:profile/src/controller/auth_controller.dart';
import 'package:profile/src/controller/login.dart';
import 'package:profile/src/utils/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //=========================== INITIAL STATE AND DISPOSE ====================================\\
  @override
  void initState() {
    AuthController.instance.checkAuth();
    super.initState();
  }

  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLER ====================================\\
  final TextEditingController _userNameEC = TextEditingController();
  final TextEditingController _userPasswordEC = TextEditingController();

  //=========================== KEYS ====================================\\
  final _formKey = GlobalKey<FormState>();

  //=========================== FOCUS NODES ====================================\\
  final FocusNode userNameFN = FocusNode();
  final FocusNode _userPasswordFN = FocusNode();

  //=========================== FUNCTIONS ====================================\\

  void _toSignupPage() => Get.off(
        () => const SignUp(),
        routeName: 'SignUp',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

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
          child: GetBuilder<LoginController>(builder: (controller) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kSizedBox,
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w700),
                            ),
                            kSizedBox,
                            Text(
                              'Please log in to your account',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            kSizedBox,
                          ],
                        ),
                      ),
                      kSizedBox,
                      Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: CircleAvatar(
                          radius: 250 / 2,
                          child: Image.asset('assets/avatar/profile.png'),
                        ),
                      ),
                      kSizedBox,
                      kSizedBox,
                      const FormText(text: 'Username'),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: _userNameEC,
                        validator: (value) {
                          RegExp userNamePattern = RegExp(
                            r'^.{3,}$', //Min. of 3 characters
                          );
                          if (value == null || value!.isEmpty) {
                            userNameFN.requestFocus();
                            return "Enter your username";
                          } else if (!userNamePattern.hasMatch(value)) {
                            userNameFN.requestFocus();
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userNameEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        nameFocusNode: userNameFN,
                        hintText: "Enter username",
                      ),
                      kSizedBox,
                      const FormText(text: 'Password'),
                      kHalfSizedBox,
                      MyTextFormField(
                        hintText: "****************",
                        controller: _userPasswordEC,
                        nameFocusNode: _userPasswordFN,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isLoading.value,
                        textInputAction: TextInputAction.go,
                        validator: (value) {
                          RegExp passwordPattern = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                          if (value == null || value!.isEmpty) {
                            _userPasswordFN.requestFocus();
                            return "Enter your password";
                          } else if (!passwordPattern.hasMatch(value)) {
                            _userPasswordFN.requestFocus();
                            return "Password needs to match format below.";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userPasswordEC.text = value;
                        },
                        suffixIcon: IconButton(
                          onPressed: controller.setShowPassword,
                          icon: controller.showPassword.value
                              ? const Icon(
                                  Icons.visibility,
                                )
                              : const Icon(
                                  Icons.visibility_off_rounded,
                                  color: kSecondaryColor,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                kSizedBox,
                kSizedBox,
                MyElevatedButton(
                  title: "LOG IN",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      controller.login(
                          username: _userNameEC.text,
                          password: _userPasswordEC.text);
                    }
                  },
                  isLoading: controller.isLoading.value,
                ),
                kHalfSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont't have an account? ",
                      style: TextStyle(
                        color: Color(0xFF646982),
                      ),
                    ),
                    TextButton(
                      onPressed: _toSignupPage,
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: kAccentColor),
                      ),
                    ),
                  ],
                ),
                kHalfSizedBox,
              ],
            );
          }),
        ),
      ),
    );
  }
}
