import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profile/src/utils/constants.dart';

class RowTextIcon extends StatelessWidget {
  final Icon icon;
  final String right;
  const RowTextIcon({super.key, required this.icon, required this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          Expanded(
            flex: 1,
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
