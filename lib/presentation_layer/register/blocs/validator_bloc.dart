import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/email_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/first_name_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/form_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/last_name_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/password_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/repeated_password_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validator_state/user_validator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatorBloc extends Bloc<FormValidationEvent, UserValidatorState> {
  ValidatorBloc() : super(const UserValidatorState()) {
    on<FirstNameValidationEvent>(_onFirstNameChanged);
    on<LastNameValidationEvent>(_onLastNameChanged);
    on<EmailValidationEvent>(_onEmailChanged);
    on<PasswordValidationEvent>(_onPasswordChanged);
    on<RepeatedPasswordValidationEvent>(_onRepeatPasswordChanged);
  }

  _onFirstNameChanged(
    FirstNameValidationEvent event,
    Emitter<UserValidatorState> emit,
  ) {
    emit(_validate(state.copyWith(firstName: event.firstName)));
  }

  _onLastNameChanged(
    LastNameValidationEvent event,
    Emitter<UserValidatorState> emit,
  ) {
    emit(_validate(state.copyWith(lastName: event.lastName)));
  }

  _onEmailChanged(
    EmailValidationEvent event,
    Emitter<UserValidatorState> emit,
  ) {
    emit(_validate(state.copyWith(email: event.email)));
  }

  _onPasswordChanged(
    PasswordValidationEvent event,
    Emitter<UserValidatorState> emit,
  ) {
    emit(_validate(state.copyWith(password: event.password)));
  }

  _onRepeatPasswordChanged(
    RepeatedPasswordValidationEvent event,
    Emitter<UserValidatorState> emit,
  ) {
    emit(_validate(state.copyWith(repeatPassword: event.repeatedPassword)));
  }

  UserValidatorState _validate(UserValidatorState state) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );

    String? firstNameError;
    String? lastNameError;
    String? emailError;
    String? passwordError;
    String? repeatPasswordError;

    if (state.firstName.trim().isEmpty) {
      firstNameError = 'First name cannot be empty';
    }

    if (state.lastName.trim().isEmpty) {
      lastNameError = 'Last name cannot be empty';
    }

    if (state.email.trim().isEmpty) {
      emailError = 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(state.email)) {
      emailError = 'Enter a valid email';
    }

    if (state.password.isEmpty) {
      passwordError = 'Password cannot be empty';
    } else if (!passwordRegex.hasMatch(state.password)) {
      passwordError =
          'Must be at least 8 characters with capital case, lower case, a number and a symbol';
    }

    if (state.repeatPassword.isEmpty) {
      repeatPasswordError = 'Repeat password cannot be empty';
    } else if (state.password != state.repeatPassword) {
      repeatPasswordError = 'Passwords do not match';
    }

    final isValid = [
      firstNameError,
      lastNameError,
      emailError,
      passwordError,
      repeatPasswordError,
    ].every((e) => e == null);

    return state.copyWith(
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      emailError: emailError,
      passwordError: passwordError,
      repeatPasswordError: repeatPasswordError,
      isValid: isValid,
    );
  }
}
