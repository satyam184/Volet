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
          CustomTextField(
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                return 'Name can only contain letters';
              } else if (value.trim().length < 2) {
                return 'Name must be at least 2 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Email'),
          CustomTextField(
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter email';
              } else if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Phone Number'),
          CustomTextField(
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter phone number';
              } else if (!RegExp(r'^[1-9][0-9]{9}$').hasMatch(value)) {
                return 'Enter valid 10-digit phone (no leading 0)';
              }
              return null;
            },
          ),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Password'),
          CustomTextField(
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Password must contain at least one special character';
              }
              return null;
            },
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
            validator: (value) {
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.visibility),
            ),
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
