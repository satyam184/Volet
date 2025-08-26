import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logging/logging.dart';
import 'package:wallet/utils/enums.dart';

part 'login_signup_event.dart';
part 'login_signup_state.dart';

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  LoginSignupBloc() : super(LoginSignupInitial()) {
    // Login
    on<OnLoginEmailChanged>(_onLoginEmailChanged);
    on<OnLoginPasswordChanged>(_onLoginPasswordChanged);
    on<OnLoginPasswordVisible>(_onLoginPasswordVisible);
    on<OnLoginSumbitted>(_onLoginSubmitted);

    // Signup
    on<OnSignUpChanged>(_onSignUpChanged);
    on<OnSignUpEmailChanged>(_onSignUpEmailChanged);
    on<OnSignUpPhoneChanged>(_onSignUpPhoneChanged);
    on<OnSignUpPasswordChanged>(_onSignUpPasswordChanged);
    on<OnSignUpConfirmPasswordChanged>(_onSignUpConfirmPasswordChanged);
    on<OnSignUpSubmitted>(_onSignUpSubmitted);
  }
  final log = Logger('LoginSignupBloc');

  // -------------------- Login --------------------

  void _onLoginEmailChanged(
    OnLoginEmailChanged event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(state.copyWith(loginEmail: event.loginEmail));
  }

  void _onLoginPasswordChanged(
    OnLoginPasswordChanged event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(state.copyWith(loginPassword: event.loginPassword));
  }

  void _onLoginPasswordVisible(
    OnLoginPasswordVisible event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(state.copyWith(isLoginPasswordVisible: !state.isLoginPasswordVisible));
  }

  Future<void> _onLoginSubmitted(
    OnLoginSumbitted event,
    Emitter<LoginSignupState> emit,
  ) async {
    emit(state.copyWith(loginPostApiStatus: LoginPostApiStatus.loading));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.loginEmail,
        password: state.loginPassword,
      );
      emit(state.copyWith(loginPostApiStatus: LoginPostApiStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          loginPostApiStatus: LoginPostApiStatus.error,
          loginError: e.code.replaceAll('-', ' '),
        ),
      );
    } on SocketException {
      emit(
        state.copyWith(
          loginPostApiStatus: LoginPostApiStatus.error,
          loginError: "No internet connection. Please check your network",
        ),
      );
    } on TimeoutException {
      emit(
        state.copyWith(
          loginPostApiStatus: LoginPostApiStatus.error,
          loginError: "Request timed out. Try again later",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loginPostApiStatus: LoginPostApiStatus.error,
          loginError: "Something went wrong. Please try again.",
        ),
      );
    }
  }

  // -------------------- Sign Up --------------------

  void _onSignUpChanged(OnSignUpChanged event, Emitter<LoginSignupState> emit) {
    emit(state.copyWith(signupFullName: event.signupFullName));
  }

  void _onSignUpEmailChanged(
    OnSignUpEmailChanged event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(state.copyWith(signupEmail: event.signupEmail));
  }

  void _onSignUpPhoneChanged(
    OnSignUpPhoneChanged event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(state.copyWith(signupPhoneNumber: event.signupPhoneNumber));
  }

  void _onSignUpPasswordChanged(
    OnSignUpPasswordChanged event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(state.copyWith(signupPassword: event.signupPassword));
  }

  void _onSignUpConfirmPasswordChanged(
    OnSignUpConfirmPasswordChanged event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(state.copyWith(signupConfirmPassword: event.signupConfirmPassword));
  }

  void _onSignUpSubmitted(
    OnSignUpSubmitted event,
    Emitter<LoginSignupState> emit,
  ) {
    // TODO: Add your signup API call or validation here
  }
}
