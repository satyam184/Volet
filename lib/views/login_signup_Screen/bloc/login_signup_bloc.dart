import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';
import 'package:wallet/utils/enums.dart';

part 'login_signup_event.dart';
part 'login_signup_state.dart';

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  LoginSignupBloc() : super(LoginSignupInitial()) {
    // Login
    on<OnLoginPasswordVisible>(_onLoginPasswordVisible);
    on<OnLoginSumbitted>(_onLoginSubmitted);

    // Signup
    on<OnSignUpPasswordVisible>(_onSignUpPasswordVisible);
    on<OnSignUpConfirmPasswordVisible>(_onSignUpConfirmPasswordVisible);
    on<OnSignUpSubmitted>(_onSignUpSubmitted);
    on<OnGoogleSignIn>(_onGoogleSignIn);
  }
  final log = Logger('LoginSignupBloc');

  // -------------------- Login --------------------
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
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.loginEmail.trim(),
        password: event.loginPassword.trim(),
      );
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

  Future<void> _onGoogleSignIn(
    OnGoogleSignIn event,
    Emitter<LoginSignupState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '811862823354-6vd7pbvbu1c6rp0g9fmon5tb1fg37rtt.apps.googleusercontent.com',
      );
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(state.copyWith(postApiStatus: PostApiStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          postApiStatus: PostApiStatus.error,
          error: e.code.replaceAll('-', ''),
        ),
      );
      log.fine('error firbaseAuth: ${e.code}');
    } on Exception catch (e) {
      emit(
        state.copyWith(postApiStatus: PostApiStatus.error, error: e.toString()),
      );
      log.fine('error firbaseAuth: $e');
    }
  }

  // -------------------- Sign Up --------------------
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
    try {
      // emit(state.copyWith(postApiStatus: PostApiStatus.loading));
      // log.fine(
      //   'signupPassword: ${event.signupPassword}, signupConfirmPassword: ${event.signupConfirmPassword}, email: ${event.signupEmail}',
      // );
      emit(
        state.copyWith(
          signupPassword: event.signupPassword.trim(),
          signupConfirmPassword: event.signupConfirmPassword.trim(),
          postApiStatus: PostApiStatus.loading,
        ),
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: event.signupEmail.trim(),
            password: event.signupPassword.trim(),
          );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': event.signupFullName.trim(),
            'email': event.signupEmail.trim(),
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
