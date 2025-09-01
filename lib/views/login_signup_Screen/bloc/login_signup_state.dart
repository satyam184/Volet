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
    this.photoUrl = '',
    this.email = '',
    this.name = '',
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

  final String photoUrl;
  final String email;
  final String name;

  LoginSignupState copyWith({
    bool? isLoginPasswordVisible,
    String? error,
    GoogleSignInStatus? googleSignInStatus,
    String? signupPassword,
    String? signupConfirmPassword,
    bool? isSignupPasswordVisible,
    bool? isSignupConfirmPasswordVisible,
    PostApiStatus? postApiStatus,
    String? photoUrl,
    String? email,
    String? name,
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
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      name: name ?? this.name,
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
    photoUrl,
    name,
    email,
  ];
}

final class LoginSignupInitial extends LoginSignupState {}
