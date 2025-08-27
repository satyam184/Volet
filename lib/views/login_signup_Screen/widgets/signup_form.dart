import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/components/snack_bar.dart';
import 'package:wallet/utils/enums.dart';
import 'package:wallet/utils/screen_util.dart';
import 'package:wallet/views/login_signup_Screen/bloc/login_signup_bloc.dart';
import 'package:wallet/views/login_signup_Screen/widgets/custom_text_field.dart';
import 'package:wallet/views/login_signup_Screen/widgets/text_field_heading.dart';

class SignupForm extends StatelessWidget {
  SignupForm({super.key});
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil.height(3)),
            TextFieldHeading(text: 'Full Name'),
            CustomTextField(
              onChanged: (value) {
                context.read<LoginSignupBloc>().add(
                  OnSignUpChanged(signupFullName: value.trim()),
                );
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Name can only contain letters';
                }
                return null;
              },
            ),
            SizedBox(height: ScreenUtil.height(2)),
            TextFieldHeading(text: 'Email'),
            CustomTextField(
              onChanged: (value) {
                context.read<LoginSignupBloc>().add(
                  OnSignUpEmailChanged(signupEmail: value.trim()),
                );
              },
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
              onChanged: (value) {
                context.read<LoginSignupBloc>().add(
                  OnSignUpPhoneChanged(signupPhoneNumber: value.trim()),
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                } else if (!RegExp(r'^[1-9][0-9]{9}$').hasMatch(value)) {
                  return 'Enter valid 10-digit phone';
                }
                return null;
              },
            ),
            SizedBox(height: ScreenUtil.height(2)),
            TextFieldHeading(text: 'Password'),
            BlocBuilder<LoginSignupBloc, LoginSignupState>(
              builder: (context, state) {
                return CustomTextField(
                  onChanged: (value) {
                    context.read<LoginSignupBloc>().add(
                      OnSignUpPasswordChanged(signupPassword: value.trim()),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    } else if (!RegExp(
                      r'[!@#$%^&*(),.?":{}|<>]',
                    ).hasMatch(value)) {
                      return 'Password must contain at least one special character';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<LoginSignupBloc>().add(
                        OnSignUpPasswordVisible(),
                      );
                    },
                    icon: state.isSignupPasswordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  obsecure: !state.isSignupPasswordVisible,
                );
              },
            ),
            SizedBox(height: ScreenUtil.height(2)),
            TextFieldHeading(text: 'Confirm Password'),
            BlocBuilder<LoginSignupBloc, LoginSignupState>(
              builder: (context, state) {
                return CustomTextField(
                  onChanged: (value) {
                    context.read<LoginSignupBloc>().add(
                      OnSignUpConfirmPasswordChanged(
                        signupConfirmPassword: value.trim(),
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter confirm password";
                    } else if (state.signupPassword.isEmpty) {
                      return "Please enter password first";
                    } else if (value.trim() != state.signupPassword.trim()) {
                      return "Passwords do not match";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<LoginSignupBloc>().add(
                        OnSignUpConfirmPasswordVisible(),
                      );
                    },
                    icon: state.isSignupConfirmPasswordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  obsecure: !state.isSignupConfirmPasswordVisible,
                );
              },
            ),
            BlocConsumer<LoginSignupBloc, LoginSignupState>(
              listenWhen: (previous, current) =>
                  previous.postApiStatus != current.postApiStatus,
              listener: (context, state) {
                if (state.postApiStatus == PostApiStatus.loading) {
                  if (state.postApiStatus == PostApiStatus.error) {
                    snackBar(
                      context,
                      message: state.error,
                      icon: Icons.cancel_rounded,
                      backgroundColor: Colors.red,
                    );
                  } else if (state.postApiStatus == PostApiStatus.success) {
                    Navigator.pop(context);
                  }
                }
              },
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.only(top: ScreenUtil.height(4)),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_signupFormKey.currentState!.validate()) {
                          context.read<LoginSignupBloc>().add(
                            OnSignUpSubmitted(),
                          );
                        }
                      },
                      child: state.postApiStatus == PostApiStatus.loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                              constraints: BoxConstraints(
                                minHeight: ScreenUtil.height(2),
                                minWidth: ScreenUtil.height(2),
                              ),
                            )
                          : Text('Sign Up'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
