import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:profile/app/login.dart';
import 'package:profile/components/button/my_elevatedbutton.dart';
import 'package:profile/components/model/image_model.dart';
import 'package:profile/components/text/form_text.dart';
import 'package:profile/components/textformfield/my_intl_phonefield.dart';
import 'package:profile/components/textformfield/textformfield.dart';
import 'package:profile/utils/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //=========================== INITIAL STATE AND DISPOSE ====================================\\
  @override
  void initState() {
    super.initState();
  }

  //=========================== ALL VARIABBLES ====================================\\
  String countryDialCode = '234';
  final bool _isLoading = false;
  bool isPWSuccess = true;
  bool _isObscured = true;

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
            top: kDefaultPadding / 2,
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
          ),
          child: ListView(
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
                          kSizedBox,
                        ],
                      ),
                    ),
                    kSizedBox,
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 250,
                          child: CircleAvatar(
                            radius: 250 / 2,
                            child: Image.asset('assets/avatar/profile.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 100,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                elevation: 20,
                                barrierColor: kBlackColor.withOpacity(0.8),
                                showDragHandle: true,
                                useSafeArea: true,
                                isDismissible: true,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      kDefaultPadding,
                                    ),
                                  ),
                                ),
                                enableDrag: true,
                                builder: (builder) => const ImageModel(),
                              );
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(5),
                              decoration: ShapeDecoration(
                                color: kAccentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.pencil,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    MyIntlPhoneField(
                      controller: _userPhoneNumberEC,
                      initialCountryCode: "NG",
                      invalidNumberMessage: "Invalid Phone Number",
                      dropdownIconPosition: IconPosition.trailing,
                      showCountryFlag: true,
                      showDropdownIcon: true,
                      onCountryChanged: (country) {
                        countryDialCode = country.dialCode;
                      },
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: kAccentColor,
                      ),
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return "Enter your phone number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPhoneNumberEC.text = value!;
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
                      obscureText: _isObscured,
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
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                        icon: _isObscured
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
                onSuccess: () {
                  setState(() {
                    isPWSuccess = true;
                  });
                },
                onFail: () {
                  setState(() {
                    isPWSuccess = false;
                  });
                },
              ),
              kSizedBox,
              MyElevatedButton(
                title: "SIGN UP",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {}
                },
                isLoading: _isLoading,
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
                      style: TextStyle(color: kAccentColor),
                    ),
                  ),
                ],
              ),
              kHalfSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
