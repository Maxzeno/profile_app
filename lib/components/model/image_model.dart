import 'package:flutter/material.dart';
import 'package:profile/utils/constants.dart';

class ImageModel extends StatelessWidget {
  const ImageModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Profile photo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          kSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      // uploadProfilePic(ImageSource.camera);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(
                            width: 0.5,
                            color: kGreyColor,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  const Text(
                    "Camera",
                  ),
                ],
              ),
              kWidthSizedBox,
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      // uploadProfilePic(ImageSource.gallery);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: const BorderSide(
                            width: 0.5,
                            color: kGreyColor,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.image,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                  kHalfSizedBox,
                  const Text(
                    "Gallery",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
