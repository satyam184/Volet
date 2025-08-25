import 'package:flutter/material.dart';
import 'package:wallet/utils/screen_util.dart';

class RememberMeAndForgotPassword extends StatelessWidget {
  const RememberMeAndForgotPassword({
    super.key,
    required this.isChecked,
    required this.forgotPassword,
  });

  final ValueNotifier<bool> isChecked;
  final void Function(String) forgotPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.width(2)),
      child: Row(
        children: [
          Row(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: isChecked,
                builder: (context, value, _) {
                  return Checkbox(
                    value: value,
                    onChanged: (value) {
                      isChecked.value = value!;
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: const BorderSide(color: Color(0xFFd5d5de), width: 2),
                    checkColor: Color(0xFF20202D),
                    activeColor: Color(0xFFd5d5de),
                  );
                },
              ),
              Text(
                'Remember me',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(left: ScreenUtil.width(19)),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
