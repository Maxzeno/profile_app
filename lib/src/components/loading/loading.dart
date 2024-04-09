import 'package:flutter/material.dart';
import 'package:profile/src/utils/constants.dart';

class Loading extends StatelessWidget {
  final Color color;

  const Loading({
    super.key,
    this.color = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color);
  }
}
