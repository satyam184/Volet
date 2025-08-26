import 'package:flutter/material.dart';
import 'package:wallet/utils/screen_util.dart';
import 'package:wallet/views/login_signup_Screen/widgets/custom_text_field.dart';
import 'package:wallet/views/login_signup_Screen/widgets/text_field_heading.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil.height(3)),
          TextFieldHeading(text: 'Full Name'),
          CustomTextField(onChanged: (value) {}),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Email'),
          CustomTextField(onChanged: (value) {}),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Phone Number'),
          CustomTextField(onChanged: (value) {}),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Password'),
          CustomTextField(
            onChanged: (value) {},
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.visibility),
            ),
            obsecure: true,
          ),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Confirm Password'),
          CustomTextField(
            onChanged: (value) {},
            // suffixIcon: IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.visibility),
            // ),
            obsecure: true,
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil.height(4)),
            child: Center(
              child: ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
            ),
          ),
        ],
      ),
    );
  }
}
