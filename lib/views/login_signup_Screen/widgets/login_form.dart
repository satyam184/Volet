import 'package:flutter/material.dart';
import 'package:wallet/utils/screen_util.dart';
import 'package:wallet/views/login_signup_Screen/widgets/custom_text_field.dart';
import 'package:wallet/views/login_signup_Screen/widgets/google_button.dart';
import 'package:wallet/views/login_signup_Screen/widgets/or.dart';
import 'package:wallet/views/login_signup_Screen/widgets/remember_me_and_forgot_password.dart';
import 'package:wallet/views/login_signup_Screen/widgets/text_field_heading.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void dispose() {
    isChecked.dispose();
    super.dispose();
  }

  final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil.height(3)),
          TextFieldHeading(text: 'Email'),
          CustomTextField(onChanged: (value) {}),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Password'),
          CustomTextField(
            onChanged: (value) {},
            icon: Icon(Icons.visibility),
            obsecure: true,
          ),
          RememberMeAndForgotPassword(
            isChecked: isChecked,
            forgotPassword: (p0) {},
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil.height(12)),
            child: Center(
              child: ElevatedButton(onPressed: () {}, child: Text('Login')),
            ),
          ),
          Or(),
          Center(child: GoogleButton(onPressed: () {})),
        ],
      ),
    );
  }
}
