import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';
import 'package:wallet/components/custom_toggle_button.dart';
import 'package:wallet/utils/images.dart';
import 'package:wallet/utils/screen_util.dart';
import 'package:wallet/views/login_signup_Screen/widgets/custom_text_field.dart';
import 'package:wallet/views/login_signup_Screen/widgets/login_form.dart';
import 'package:wallet/views/login_signup_Screen/widgets/signup_form.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginSignup> {
  final log = Logger('LoginScreen');

  final PageController _pageController = PageController();
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedIndex.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                          children: [LoginForm(), SignupForm()],
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
