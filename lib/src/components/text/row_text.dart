import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profile/src/utils/constants.dart';

class RowText extends StatelessWidget {
  final String left;
  final String right;
  const RowText({super.key, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              left,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              right,
              textAlign: TextAlign.end,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kTextBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
