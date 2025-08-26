part of 'login_signup_bloc.dart';

abstract class LoginSignupEvent extends Equatable {
  const LoginSignupEvent();

  @override
  List<Object> get props => [];
}

// ---- Login fields ----
class OnLoginEmailChanged extends LoginSignupEvent {
  const OnLoginEmailChanged({required this.loginEmail});
  final String loginEmail;

  @override
  List<Object> get props => [loginEmail];
}

class OnLoginPasswordChanged extends LoginSignupEvent {
  const OnLoginPasswordChanged({required this.loginPassword});
  final String loginPassword;

  @override
  List<Object> get props => [loginPassword];
}

class OnLoginPasswordVisible extends LoginSignupEvent {}

class OnLoginSumbitted extends LoginSignupEvent {
  const OnLoginSumbitted();
}

// ---- Signup fields ----
class OnSignUpChanged extends LoginSignupEvent {
  const OnSignUpChanged({required this.signupFullName});
  final String signupFullName;

  @override
  List<Object> get props => [signupFullName];
}

class OnSignUpEmailChanged extends LoginSignupEvent {
  const OnSignUpEmailChanged(this.signupEmail);
  final String signupEmail;

  @override
  List<Object> get props => [signupEmail];
}

class OnSignUpPhoneChanged extends LoginSignupEvent {
  const OnSignUpPhoneChanged(this.signupPhoneNumber);
  final String signupPhoneNumber;

  @override
  List<Object> get props => [signupPhoneNumber];
}

class OnSignUpPasswordChanged extends LoginSignupEvent {
  const OnSignUpPasswordChanged(this.signupPassword);
  final String signupPassword;

  @override
  List<Object> get props => [signupPassword];
}

class OnSignUpConfirmPasswordChanged extends LoginSignupEvent {
  const OnSignUpConfirmPasswordChanged(this.signupConfirmPassword);
  final String signupConfirmPassword;

  @override
  List<Object> get props => [signupConfirmPassword];
}

class OnSignUpSubmitted extends LoginSignupEvent {
  const OnSignUpSubmitted();
}
