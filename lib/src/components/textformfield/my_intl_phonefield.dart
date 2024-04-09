import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:profile/src/utils/constants.dart';

class MyIntlPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String initialCountryCode;
  final String invalidNumberMessage;
  final IconPosition dropdownIconPosition;
  final bool showCountryFlag;
  final bool showDropdownIcon;
  final Icon dropdownIcon;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final void Function(PhoneNumber?)? onSaved;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final void Function(Country country)? onCountryChanged;
  const MyIntlPhoneField({
    super.key,
    required this.controller,
    required this.initialCountryCode,
    required this.invalidNumberMessage,
    required this.dropdownIconPosition,
    required this.showCountryFlag,
    required this.showDropdownIcon,
    required this.dropdownIcon,
    required this.textInputAction,
    required this.focusNode,
    this.onSaved,
    this.validator,
    this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      countries: const [
        Country(
          name: "Nigeria",
          nameTranslations: {
            "en": "Nigeria",
          },
          flag: "🇳🇬",
          code: "NG",
          dialCode: "234",
          minLength: 10,
          maxLength: 10,
        ),
      ],
      controller: controller,
      initialCountryCode: initialCountryCode,
      invalidNumberMessage: invalidNumberMessage,
      dropdownIconPosition: dropdownIconPosition,
      showCountryFlag: showCountryFlag,
      keyboardType: TextInputType.number,
      showDropdownIcon: showDropdownIcon,
      dropdownIcon: dropdownIcon,
      textInputAction: textInputAction,
      focusNode: focusNode,
      validator: validator,
      onSaved: onSaved,
      flagsButtonPadding: const EdgeInsets.all(kDefaultPadding / 2),
      cursorColor: kSecondaryColor,
      onChanged: (phone) {},
      onCountryChanged: onCountryChanged,
      style: const TextStyle(
        color: kSecondaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: "Enter phone Number",
        errorStyle: const TextStyle(
          color: kErrorColor,
        ),
        filled: true,
        fillColor: Colors.blue.shade50,
        focusColor: Colors.blue.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade50,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade50,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: BorderSide(
            color: Colors.blue.shade50,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: const BorderSide(
            color: kErrorBorderColor,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          borderSide: const BorderSide(
            color: kErrorBorderColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
