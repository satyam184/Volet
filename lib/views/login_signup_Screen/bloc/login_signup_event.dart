part of 'login_signup_bloc.dart';

abstract class LoginSignupEvent extends Equatable {
  const LoginSignupEvent();

  @override
  List<Object> get props => [];
}

// ---- Login ----
class OnLoginPasswordVisible extends LoginSignupEvent {}

class OnLoginSumbitted extends LoginSignupEvent {
  const OnLoginSumbitted({
    required this.loginEmail,
    required this.loginPassword,
  });
  final String loginEmail;
  final String loginPassword;

  @override
  List<Object> get props => [loginEmail, loginPassword];
}

// ---- Signup fields ----
class OnSignUpPasswordVisible extends LoginSignupEvent {}

class OnSignUpConfirmPasswordVisible extends LoginSignupEvent {}

class OnSignUpSubmitted extends LoginSignupEvent {
  const OnSignUpSubmitted({
    required this.signupFullName,
    required this.signupEmail,
    required this.signupPhoneNumber,
    required this.signupPassword,
    required this.signupConfirmPassword,
  });
  final String signupFullName;
  final String signupEmail;
  final String signupPhoneNumber;
  final String signupPassword;
  final String signupConfirmPassword;

  @override
  List<Object> get props => [
    signupFullName,
    signupEmail,
    signupPhoneNumber,
    signupPassword,
    signupConfirmPassword,
  ];
}

class OnGoogleSignIn extends LoginSignupEvent {}

class OnExtractDetails extends LoginSignupEvent {
  const OnExtractDetails({
    required this.photoUrl,
    required this.email,
    required this.name,
  });
  final String photoUrl;
  final String email;
  final String name;

  @override
  List<Object> get props => [photoUrl, email, name];
}
