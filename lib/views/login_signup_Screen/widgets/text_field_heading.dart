import 'package:flutter/material.dart';
import 'package:wallet/utils/screen_util.dart';

class TextFieldHeading extends StatelessWidget {
  const TextFieldHeading({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.width(5)),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
