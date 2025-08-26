import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/components/snack_bar.dart';
import 'package:wallet/utils/enums.dart';
import 'package:wallet/utils/screen_util.dart';
import 'package:wallet/views/dashBoard/dashboard.dart';
import 'package:wallet/views/login_signup_Screen/bloc/login_signup_bloc.dart';
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
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil.height(3)),
            TextFieldHeading(text: 'Email'),
            CustomTextField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please Enter Email';
                }
                return null;
              },
              onChanged: (value) {
                context.read<LoginSignupBloc>().add(
                  OnLoginEmailChanged(loginEmail: value.trim()),
                );
              },
            ),
            SizedBox(height: ScreenUtil.height(2)),
            TextFieldHeading(text: 'Password'),
            CustomTextField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
              onChanged: (value) {
                context.read<LoginSignupBloc>().add(
                  OnLoginPasswordChanged(loginPassword: value.trim()),
                );
              },
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
                child: BlocConsumer<LoginSignupBloc, LoginSignupState>(
                  listenWhen: (previous, current) =>
                      previous.loginPostApiStatus != current.loginPostApiStatus,
                  listener: (context, state) {
                    if (state.loginPostApiStatus == LoginPostApiStatus.error) {
                      snackBar(
                        context,
                        message: state.loginError,
                        icon: Icons.cancel_rounded,
                        backgroundColor: Colors.red,
                      );
                    } else if (state.loginPostApiStatus ==
                        LoginPostApiStatus.success) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_loginFormKey.currentState!.validate()) {
                          context.read<LoginSignupBloc>().add(
                            OnLoginSumbitted(),
                          );
                        }
                      },
                      child:
                          state.loginPostApiStatus == LoginPostApiStatus.loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                              constraints: BoxConstraints(
                                minHeight: ScreenUtil.height(2),
                                minWidth: ScreenUtil.height(2),
                              ),
                            )
                          : Text('Login'),
                    );
                  },
                ),
              ),
            ),
            Or(),
            Center(child: GoogleButton(onPressed: () {})),
          ],
        ),
      ),
    );
  }
}
