import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  @override
  void dispose() {
    _userNameEC.dispose();
    _userPasswordEC.dispose();
    _userNameFN.dispose();
    _userPasswordFN.dispose();
    super.dispose();
  }
  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLER ====================================\\
  final TextEditingController _userNameEC = TextEditingController();
  final TextEditingController _userPasswordEC = TextEditingController();

  //=========================== KEYS ====================================\\
  final _formKey = GlobalKey<FormState>();

  //=========================== FOCUS NODES ====================================\\
  final FocusNode _userNameFN = FocusNode();
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
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          child: GetBuilder<LoginController>(builder: (controller) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: kDefaultPadding * 2),
                  alignment: Alignment.center,
                  height: 200,
                  child: const CircleAvatar(
                    radius: 200 / 2,
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.unlockKeyhole,
                        color: kSecondaryColor,
                        size: 80,
                        semanticLabel: "login__success_icon",
                      ),
                    ),
                  ),
                ),
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
                    ],
                  ),
                ),
                kSizedBox,
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kSizedBox,
                      const FormText(text: 'Username'),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: _userNameEC,
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            _userNameFN.requestFocus();
                            return "Enter your username";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userNameEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        nameFocusNode: _userNameFN,
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
                        obscureText: controller.hidePassword.value,
                        textInputAction: TextInputAction.go,
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            _userPasswordFN.requestFocus();
                            return "Enter your password";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userPasswordEC.text = value;
                        },
                        suffixIcon: IconButton(
                          onPressed: controller.setHidePassword,
                          icon: !controller.hidePassword.value
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
                        style: TextStyle(color: kMainRed),
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
