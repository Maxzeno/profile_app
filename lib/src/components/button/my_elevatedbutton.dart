import 'package:flutter/material.dart';
import 'package:profile/src/utils/constants.dart';

class MyElevatedButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool isLoading;

  const MyElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: kMainRed.withOpacity(0.5),
        backgroundColor: kMainRed,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: kBlackColor.withOpacity(0.4),
        minimumSize: Size(media.width, 60),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: kPrimaryColor)
          : Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontFamily: "Sen",
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
