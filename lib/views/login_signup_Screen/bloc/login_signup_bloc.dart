import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:wallet/utils/enums.dart';

part 'login_signup_event.dart';
part 'login_signup_state.dart';

class LoginSignupBloc extends Bloc<LoginSignupEvent, LoginSignupState> {
  LoginSignupBloc() : super(LoginSignupInitial()) {
    // Login
    on<OnLoginEmailChanged>(_onLoginEmailChanged);
    on<OnLoginPasswordChanged>(_onLoginPasswordChanged);
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

  Future<void> _onLoginSubmitted(
    OnLoginSumbitted event,
    Emitter<LoginSignupState> emit,
  ) async {
    emit(state.copyWith(loginPostApiStatus: LoginPostApiStatus.loading));
    await Future.delayed(const Duration(seconds: 1), () {
      log.fine('email: ${state.loginEmail}, password: ${state.loginPassword}');
    });
    emit(state.copyWith(loginPostApiStatus: LoginPostApiStatus.success));
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
