import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:profile/app/login.dart';
import 'package:profile/src/components/button/my_elevatedbutton.dart';
import 'package:profile/src/components/text/form_text.dart';
import 'package:profile/src/components/textformfield/my_phonefield.dart';
import 'package:profile/src/components/textformfield/textformfield.dart';
import 'package:profile/src/controller/auth_controller.dart';
import 'package:profile/src/controller/signup.dart';
import 'package:profile/src/utils/constants.dart';
import 'package:profile/src/utils/helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //=========================== INITIAL STATE AND DISPOSE ====================================\\
  @override
  void initState() {
    setFirstTime();
    AuthController.instance.checkAuth();
    super.initState();
  }

  //=========================== ALL VARIABBLES ====================================\\

  //=========================== CONTROLLER ====================================\\
  final TextEditingController _userNameEC = TextEditingController();
  final TextEditingController _userEmailEC = TextEditingController();
  final TextEditingController _userPhoneNumberEC = TextEditingController();
  final TextEditingController _userAddressEC = TextEditingController();
  final TextEditingController _userPasswordEC = TextEditingController();

  //=========================== KEYS ====================================\\
  final _formKey = GlobalKey<FormState>();

  //=========================== FOCUS NODES ====================================\\
  final FocusNode userNameFN = FocusNode();
  final FocusNode userAddressFN = FocusNode();
  final FocusNode _userPhoneNumberFN = FocusNode();
  final FocusNode _userEmailFN = FocusNode();
  final FocusNode _userPasswordFN = FocusNode();

  //=========================== FUNCTIONS ====================================\\
  void _toLoginPage() => Get.off(
        () => const Login(),
        routeName: 'Login',
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
          child: GetBuilder<SignupController>(builder: (controller) {
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
                        FontAwesomeIcons.lock,
                        color: kSecondaryColor,
                        size: 80,
                        semanticLabel: "lock_icon",
                      ),
                    ),
                  ),
                ),
                kSizedBox,
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                      kSizedBox,
                      Text(
                        'Please sign up to get started',
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
                      const FormText(text: 'Email'),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: _userEmailEC,
                        nameFocusNode: _userEmailFN,
                        validator: (value) {
                          RegExp emailPattern = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                          );
                          if (value == null || value!.isEmpty) {
                            _userEmailFN.requestFocus();
                            return "Enter your email address";
                          } else if (!emailPattern.hasMatch(value)) {
                            _userEmailFN.requestFocus();
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userEmailEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        hintText: "Enter email",
                      ),
                      kSizedBox,
                      const FormText(text: 'Phone Number'),
                      kHalfSizedBox,
                      MyPhoneField(
                        controller: _userPhoneNumberEC,
                        initialCountryCode: "NG",
                        invalidNumberMessage: "Invalid Phone Number",
                        dropdownIconPosition: IconPosition.trailing,
                        showCountryFlag: true,
                        showDropdownIcon: true,
                        dropdownIcon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: kMainRed,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your phone number";
                          }
                          if (value.length < 5) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            _userPhoneNumberEC.text = value;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: _userPhoneNumberFN,
                      ),
                      kSizedBox,
                      const FormText(text: 'Address'),
                      kHalfSizedBox,
                      MyTextFormField(
                        controller: _userAddressEC,
                        validator: (value) {
                          RegExp addressPattern = RegExp(
                            r'^.{3,}$', //Min. of 3 characters
                          );
                          if (value == null || value!.isEmpty) {
                            userAddressFN.requestFocus();
                            return "Enter your address";
                          } else if (!addressPattern.hasMatch(value)) {
                            userAddressFN.requestFocus();
                            return "Address must be at least 3 characters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userAddressEC.text = value;
                        },
                        textInputAction: TextInputAction.next,
                        nameFocusNode: userAddressFN,
                        hintText: "Enter address",
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
                          print('${_userPasswordEC.text} _userPasswordEC.text');
                          print('$value value');
                          // _userPasswordEC.text = value;
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
                kHalfSizedBox,
                FlutterPwValidator(
                  uppercaseCharCount: 1,
                  lowercaseCharCount: 1,
                  numericCharCount: 1,
                  controller: _userPasswordEC,
                  width: 400,
                  height: 150,
                  minLength: 8,
                  onSuccess: () => controller.setPWSuccess(true),
                  onFail: () => controller.setPWSuccess(false),
                ),
                kSizedBox,
                MyElevatedButton(
                  title: "SIGN UP",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      controller.signup(
                          username: _userNameEC.text,
                          password: _userPasswordEC.text,
                          email: _userEmailEC.text,
                          phone: "+234${_userPhoneNumberEC.text}",
                          address: _userAddressEC.text);
                    }
                  },
                  isLoading: controller.isLoading.value,
                ),
                kHalfSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Color(0xFF646982),
                      ),
                    ),
                    TextButton(
                      onPressed: _toLoginPage,
                      child: const Text(
                        "Log in",
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
