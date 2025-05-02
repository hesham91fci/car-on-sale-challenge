class UserValidatorState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String repeatPassword;

  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final String? passwordError;
  final String? repeatPasswordError;

  final bool isValid;

  const UserValidatorState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.repeatPassword = '',
    this.firstNameError,
    this.lastNameError,
    this.emailError,
    this.passwordError,
    this.repeatPasswordError,
    this.isValid = false,
  });

  UserValidatorState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? repeatPassword,
    String? firstNameError,
    String? lastNameError,
    String? emailError,
    String? passwordError,
    String? repeatPasswordError,
    bool? isValid,
  }) {
    return UserValidatorState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      repeatPassword: repeatPassword ?? this.repeatPassword,
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      emailError: emailError,
      passwordError: passwordError,
      repeatPasswordError: repeatPasswordError,
      isValid: isValid ?? this.isValid,
    );
  }
}
