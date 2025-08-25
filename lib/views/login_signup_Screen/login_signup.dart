import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';
import 'package:wallet/components/custom_toggle_button.dart';
import 'package:wallet/utils/images.dart';
import 'package:wallet/utils/screen_util.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginSignup> {
  final log = Logger('LoginScreen');

  final PageController _pageController = PageController();
  final ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedIndex.dispose();
    isChecked.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color(0xFF20202D),
        leading: Align(
          child: SvgPicture.asset(
            wallet,
            height: ScreenUtil.height(5),
            width: ScreenUtil.width(5),
          ),
        ),
        title: const Text(
          'MyVolet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF20202D),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: ScreenUtil.width(4)),
            child: const Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get Started now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Create an account or log in to explore about our app',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtil.height(78),
              width: ScreenUtil.screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, _) {
                      return CustomToggleButton(
                        selectedIndex: value,
                        backgroundColor: Color(0xFFF5F6F9),
                        tabs: const ['Login', 'Sign Up'],
                        activeTabColor: Colors.white,
                        borderRadius: 5,
                        activeTextColor: Colors.black,
                        grayContainerRadius: 5,
                        onTabSelected: (index) {
                          _pageController.animateToPage(
                            selectedIndex.value = index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: selectedIndex,
                      builder: (context, value, _) {
                        return PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            selectedIndex.value = index;
                          },
                          children: [
                            LoginForm(isChecked: isChecked),
                            SignupForm(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
            icon: Icon(Icons.visibility),
            obsecure: true,
          ),
          SizedBox(height: ScreenUtil.height(2)),
          TextFieldHeading(text: 'Confirm Password'),
          CustomTextField(
            onChanged: (value) {},
            icon: Icon(Icons.visibility),
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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.isChecked});

  final ValueNotifier<bool> isChecked;

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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    this.icon,
    this.obsecure = false,
  });
  final void Function(String) onChanged;
  final Icon? icon;
  final bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.width(5)),
      width: ScreenUtil.width(90),
      child: TextFormField(
        obscuringCharacter: '*',
        obscureText: obsecure,
        onChanged: onChanged,
        cursorColor: Color(0xFFd5d5de),
        decoration: InputDecoration(
          suffixIcon: icon,
          suffixIconColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFd5d5de), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFd5d5de), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFd5d5de), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 18,
          ),
        ),
      ),
    );
  }
}
