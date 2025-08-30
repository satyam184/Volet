part of 'login_signup_bloc.dart';

class LoginSignupState extends Equatable {
  const LoginSignupState({
    this.isLoginPasswordVisible = false,
    this.error = '',
    this.googleSignInStatus = GoogleSignInStatus.initial,
    this.signupPassword = '',
    this.signupConfirmPassword = '',
    this.isSignupPasswordVisible = false,
    this.isSignupConfirmPasswordVisible = false,
    this.postApiStatus = PostApiStatus.initial,
  });

  // ---- Login fields ----
  final bool isLoginPasswordVisible;
  final String error;
  final GoogleSignInStatus googleSignInStatus;

  // ---- Signup fields ----
  final String signupPassword;
  final String signupConfirmPassword;
  final bool isSignupPasswordVisible;
  final bool isSignupConfirmPasswordVisible;
  final PostApiStatus postApiStatus;

  LoginSignupState copyWith({
    bool? isLoginPasswordVisible,
    String? error,
    GoogleSignInStatus? googleSignInStatus,
    String? signupPassword,
    String? signupConfirmPassword,
    bool? isSignupPasswordVisible,
    bool? isSignupConfirmPasswordVisible,
    PostApiStatus? postApiStatus,
  }) {
    return LoginSignupState(
      isLoginPasswordVisible:
          isLoginPasswordVisible ?? this.isLoginPasswordVisible,
      error: error ?? this.error,
      googleSignInStatus: googleSignInStatus ?? this.googleSignInStatus,
      signupPassword: signupPassword ?? this.signupPassword,
      signupConfirmPassword:
          signupConfirmPassword ?? this.signupConfirmPassword,
      isSignupPasswordVisible:
          isSignupPasswordVisible ?? this.isSignupPasswordVisible,
      isSignupConfirmPasswordVisible:
          isSignupConfirmPasswordVisible ?? this.isSignupConfirmPasswordVisible,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    isLoginPasswordVisible,
    error,
    googleSignInStatus,
    signupPassword,
    signupConfirmPassword,
    isSignupPasswordVisible,
    isSignupConfirmPasswordVisible,
    postApiStatus,
  ];
}

final class LoginSignupInitial extends LoginSignupState {}
