part of 'login_signup_bloc.dart';

class LoginSignupState extends Equatable {
  const LoginSignupState({
    this.loginEmail = '',
    this.loginPassword = '',
    this.isLoginPasswordVisible = false,
    this.error = '',
    this.signupFullName = '',
    this.signupEmail = '',
    this.signupPhoneNumber = '',
    this.signupPassword = '',
    this.signupConfirmPassword = '',
    this.isSignupPasswordVisible = false,
    this.isSignupConfirmPasswordVisible = false,
    this.postApiStatus = PostApiStatus.initial,
  });

  // ---- Login fields ----
  final String loginEmail;
  final String loginPassword;
  final bool isLoginPasswordVisible;
  final String error;

  // ---- Signup fields ----
  final String signupFullName;
  final String signupEmail;
  final String signupPhoneNumber;
  final String signupPassword;
  final String signupConfirmPassword;
  final bool isSignupPasswordVisible;
  final bool isSignupConfirmPasswordVisible;
  final PostApiStatus postApiStatus;

  LoginSignupState copyWith({
    String? loginEmail,
    String? loginPassword,
    bool? isLoginPasswordVisible,
    String? error,
    String? signupFullName,
    String? signupEmail,
    String? signupPhoneNumber,
    String? signupPassword,
    String? signupConfirmPassword,
    bool? isSignupPasswordVisible,
    bool? isSignupConfirmPasswordVisible,
    PostApiStatus? postApiStatus,
  }) {
    return LoginSignupState(
      loginEmail: loginEmail ?? this.loginEmail,
      loginPassword: loginPassword ?? this.loginPassword,
      isLoginPasswordVisible:
          isLoginPasswordVisible ?? this.isLoginPasswordVisible,
      error: error ?? this.error,
      signupFullName: signupFullName ?? this.signupFullName,
      signupEmail: signupEmail ?? this.signupEmail,
      signupPhoneNumber: signupPhoneNumber ?? this.signupPhoneNumber,
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
    loginEmail,
    loginPassword,
    isLoginPasswordVisible,
    error,
    signupFullName,
    signupEmail,
    signupPhoneNumber,
    signupPassword,
    signupConfirmPassword,
    isSignupPasswordVisible,
    isSignupConfirmPasswordVisible,
    PostApiStatus,
  ];
}

final class LoginSignupInitial extends LoginSignupState {}
