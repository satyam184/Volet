part of 'login_signup_bloc.dart';

class LoginSignupState extends Equatable {
  const LoginSignupState({
    this.loginEmail = '',
    this.loginPassword = '',
    this.isLoginPasswordVisible = false,
    this.loginError = '',
    this.signupFullName = '',
    this.signupEmail = '',
    this.signupPhoneNumber = '',
    this.signupPassword = '',
    this.signupConfirmPassword = '',
    this.loginPostApiStatus = LoginPostApiStatus.initial,
  });

  // ---- Login fields ----
  final String loginEmail;
  final String loginPassword;
  final bool isLoginPasswordVisible;
  final String loginError;

  // ---- Signup fields ----
  final String signupFullName;
  final String signupEmail;
  final String signupPhoneNumber;
  final String signupPassword;
  final String signupConfirmPassword;
  final LoginPostApiStatus loginPostApiStatus;

  LoginSignupState copyWith({
    String? loginEmail,
    String? loginPassword,
    bool? isLoginPasswordVisible,
    String? loginError,
    String? signupFullName,
    String? signupEmail,
    String? signupPhoneNumber,
    String? signupPassword,
    String? signupConfirmPassword,
    LoginPostApiStatus? loginPostApiStatus,
  }) {
    return LoginSignupState(
      loginEmail: loginEmail ?? this.loginEmail,
      loginPassword: loginPassword ?? this.loginPassword,
      isLoginPasswordVisible:
          isLoginPasswordVisible ?? this.isLoginPasswordVisible,
      loginError: loginError ?? this.loginError,
      signupFullName: signupFullName ?? this.signupFullName,
      signupEmail: signupEmail ?? this.signupEmail,
      signupPhoneNumber: signupPhoneNumber ?? this.signupPhoneNumber,
      signupPassword: signupPassword ?? this.signupPassword,
      signupConfirmPassword:
          signupConfirmPassword ?? this.signupConfirmPassword,
      loginPostApiStatus: loginPostApiStatus ?? this.loginPostApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    loginEmail,
    loginPassword,
    isLoginPasswordVisible,
    loginError,
    signupFullName,
    signupEmail,
    signupPhoneNumber,
    signupPassword,
    signupConfirmPassword,
    loginPostApiStatus,
  ];
}

final class LoginSignupInitial extends LoginSignupState {}
