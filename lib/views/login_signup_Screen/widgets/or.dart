import 'package:flutter/material.dart';
import 'package:wallet/utils/screen_util.dart';

class Or extends StatelessWidget {
  const Or({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.width(5),
        vertical: ScreenUtil.height(2),
      ),
      child: Row(
        children: [
          Expanded(child: Divider(color: Color(0xFFd5d5de), thickness: 2)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "OR",
              style: TextStyle(
                color: Color(0xFFd5d5de),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Divider(color: Color(0xFFd5d5de), thickness: 2)),
        ],
      ),
    );
  }
}
