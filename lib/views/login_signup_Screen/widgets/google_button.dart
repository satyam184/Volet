import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/utils/images.dart';
import 'package:wallet/utils/screen_util.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Color(0xFFd5d5de)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil.height(2),
          horizontal: ScreenUtil.width(17),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(google, height: ScreenUtil.height(3)),
          SizedBox(width: 10),
          Text(
            "Continue with Google",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
