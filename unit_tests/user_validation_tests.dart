import 'package:bloc_test/bloc_test.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/blocs/validator_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/email_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/first_name_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/last_name_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/password_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/repeated_password_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validator_state/user_validator_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Matcher isNullOrEmpty = predicate<String?>(
    (s) => s == null || s.isEmpty,
    'null or empty string',
  );

  group('testing first name states', () {
    blocTest(
      'invalid firstName',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(FirstNameValidationEvent('')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.firstNameError,
              'firstName',
              isNotEmpty,
            ),
          ],
    );

    blocTest(
      'valid firstName',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(FirstNameValidationEvent('Test name')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.firstNameError,
              'firstNameError',
              isNullOrEmpty,
            ),
          ],
    );
  });

  group('testing last name states', () {
    blocTest(
      'invalid lastName',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(LastNameValidationEvent('')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.lastNameError,
              'lastNameError',
              isNotEmpty,
            ),
          ],
    );

    blocTest(
      'valid lastName',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(LastNameValidationEvent('Test name')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.lastNameError,
              'lastNameError',
              isNullOrEmpty,
            ),
          ],
    );
  });

  group('testing email states', () {
    blocTest(
      'invalid email',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(EmailValidationEvent('email')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.emailError,
              'emailError',
              isNotEmpty,
            ),
          ],
    );

    blocTest(
      'valid email',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(EmailValidationEvent('email@gmail.com')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.emailError,
              'emailError',
              isNullOrEmpty,
            ),
          ],
    );
  });

  group('testing password states', () {
    blocTest(
      'invalid password state',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(PasswordValidationEvent('test password')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.passwordError,
              'passwordError',
              isNotEmpty,
            ),
          ],
    );

    blocTest(
      'valid password state',
      build: () => ValidatorBloc(),
      act: (bloc) => bloc.add(PasswordValidationEvent('aaAA11@@')),
      expect:
          () => [
            isA<UserValidatorState>().having(
              (state) => state.passwordError,
              'passwordError',
              isNullOrEmpty,
            ),
          ],
    );
  });

  group('test form validation', () {
    blocTest(
      'test invalid form state',
      build: () => ValidatorBloc(),
      act: (bloc) {
        bloc.add(FirstNameValidationEvent('firstName'));
        bloc.add(LastNameValidationEvent('lastName'));
        bloc.add(EmailValidationEvent('email@gmail.com'));
        bloc.add(PasswordValidationEvent('aaAA11@@'));
        bloc.add(RepeatedPasswordValidationEvent('aaAA11@@@'));
      },
      verify: (bloc) => expect(bloc.state.isValid, isFalse),
    );

    blocTest(
      'test invalid form state',
      build: () => ValidatorBloc(),
      act: (bloc) {
        bloc.add(FirstNameValidationEvent('firstName'));
        bloc.add(LastNameValidationEvent('lastName'));
        bloc.add(EmailValidationEvent('email@gmail.com'));
        bloc.add(PasswordValidationEvent('aaAA11@@'));
        bloc.add(RepeatedPasswordValidationEvent('aaAA11@@'));
      },
      verify: (bloc) => expect(bloc.state.isValid, isTrue),
    );
  });
}
