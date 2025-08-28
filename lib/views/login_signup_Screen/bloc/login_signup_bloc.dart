import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:wallet/utils/enums.dart';

part 'login_signup_event.dart';
part 'login_signup_state.dart';

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  LoginSignupBloc() : super(LoginSignupInitial()) {
    // Login
    // on<OnLoginEmailChanged>(_onLoginEmailChanged);
    // on<OnLoginPasswordChanged>(_onLoginPasswordChanged);
    on<OnLoginPasswordVisible>(_onLoginPasswordVisible);
    on<OnLoginSumbitted>(_onLoginSubmitted);

    // Signup
    // on<OnSignUpChanged>(_onSignUpChanged);
    // on<OnSignUpEmailChanged>(_onSignUpEmailChanged);
    // on<OnSignUpPhoneChanged>(_onSignUpPhoneChanged);
    // on<OnSignUpPasswordChanged>(_onSignUpPasswordChanged);
    // on<OnSignUpConfirmPasswordChanged>(_onSignUpConfirmPasswordChanged);
    on<OnSignUpPasswordVisible>(_onSignUpPasswordVisible);
    on<OnSignUpConfirmPasswordVisible>(_onSignUpConfirmPasswordVisible);
    on<OnSignUpSubmitted>(_onSignUpSubmitted);
  }
  final log = Logger('LoginSignupBloc');

  // -------------------- Login --------------------

  // void _onLoginEmailChanged(
  //   OnLoginEmailChanged event,
  //   Emitter<LoginSignupState> emit,
  // ) {
  //   emit(state.copyWith(loginEmail: event.loginEmail));
  // }

  // void _onLoginPasswordChanged(
  //   OnLoginPasswordChanged event,
  //   Emitter<LoginSignupState> emit,
  // ) {
  //   emit(state.copyWith(loginPassword: event.loginPassword));
  // }

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
    try {
      log.fine("Trying login with ${event.loginEmail}");
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.loginEmail.trim(),
        password: event.loginPassword.trim(),
      );
      log.fine("Firebase login success");
      emit(state.copyWith(postApiStatus: PostApiStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: e.code.replaceAll('-', ' '),
        ),
      );
    } on SocketException {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: "No internet connection. Please check your network",
        ),
      );
    } on TimeoutException {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: "Request timed out. Try again later",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: "Something went wrong. Please try again.",
        ),
      );
    }
  }

  // -------------------- Sign Up --------------------

  // void _onSignUpChanged(OnSignUpChanged event, Emitter<LoginSignupState> emit) {
  //   emit(state.copyWith(signupFullName: event.signupFullName));
  // }

  // void _onSignUpEmailChanged(
  //   OnSignUpEmailChanged event,
  //   Emitter<LoginSignupState> emit,
  // ) {
  //   emit(state.copyWith(signupEmail: event.signupEmail));
  // }

  // void _onSignUpPhoneChanged(
  //   OnSignUpPhoneChanged event,
  //   Emitter<LoginSignupState> emit,
  // ) {
  //   emit(state.copyWith(signupPhoneNumber: event.signupPhoneNumber));
  // }

  // void _onSignUpPasswordChanged(
  //   OnSignUpPasswordChanged event,
  //   Emitter<LoginSignupState> emit,
  // ) {
  //   emit(state.copyWith(signupPassword: event.signupPassword));
  // }

  // void _onSignUpConfirmPasswordChanged(
  //   OnSignUpConfirmPasswordChanged event,
  //   Emitter<LoginSignupState> emit,
  // ) {
  //   emit(state.copyWith(signupConfirmPassword: event.signupConfirmPassword));
  // }

  void _onSignUpPasswordVisible(
    OnSignUpPasswordVisible event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(
      state.copyWith(isSignupPasswordVisible: !state.isSignupPasswordVisible),
    );
  }

  void _onSignUpConfirmPasswordVisible(
    OnSignUpConfirmPasswordVisible event,
    Emitter<LoginSignupState> emit,
  ) {
    emit(
      state.copyWith(
        isSignupConfirmPasswordVisible: !state.isSignupConfirmPasswordVisible,
      ),
    );
  }

  Future<void> _onSignUpSubmitted(
    OnSignUpSubmitted event,
    Emitter<LoginSignupState> emit,
  ) async {
    emit(
      state.copyWith(
        postApiStatus: PostApiStatus.loading,
        signupFullName: event.signupFullName,
        signupEmail: event.signupEmail,
        signupPhoneNumber: event.signupPhoneNumber,
        signupPassword: event.signupPassword,
        signupConfirmPassword: event.signupConfirmPassword,
      ),
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: state.signupEmail,
            password: state.signupPassword,
          );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': state.signupFullName,
            'email': state.signupEmail,
            'createdAt': DateTime.now(),
          });
      emit(state.copyWith(postApiStatus: PostApiStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: e.code.replaceAll('-', ' '),
        ),
      );
    } on SocketException {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: "No internet connection. Please check your network",
        ),
      );
    } on TimeoutException {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: "Request timed out. Try again later",
        ),
      );
    }
  }
}
