import 'package:car_on_sale_challenge/Base/base_stateful_widget.dart';
import 'package:car_on_sale_challenge/base/bloc/bloc_base_common_state.dart';
import 'package:car_on_sale_challenge/business_layer/module_configurator.dart';
import 'package:car_on_sale_challenge/business_layer/ui_models/textfield_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/cos_textfield.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/local_success_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/blocs/register_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/blocs/validator_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_events/register_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_events/remember_me_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_state/remember_me_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/email_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/first_name_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/last_name_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/password_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/repeated_password_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/user_validator_state/user_validator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends BaseStatefulWidget {
  static const String routeName = '/register';
  const RegisterPage({super.key});
  @override
  BaseState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage> {
  RegisterBloc? _registerBloc;
  ValidatorBloc? _validatorBloc;
  static const String _firstName = "firstName";
  static const String _lastName = "lastName";
  static const String _email = "email";
  static const String _password = "password";
  static const String _repeatPassword = "repeatPassword";
  final Map<String, TextFieldState> _textfieldStateMap = {
    _firstName: TextFieldState(controller: TextEditingController()),
    _lastName: TextFieldState(controller: TextEditingController()),
    _email: TextFieldState(controller: TextEditingController()),
    _password: TextFieldState(),
    _repeatPassword: TextFieldState(),
  };
  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _validatorBloc = BlocProvider.of<ValidatorBloc>(context);
    _registerBloc?.add(RememberMeEvent(false));
  }

  @override
  Widget getBody(BuildContext context) {
    return BlocBuilder<ValidatorBloc, UserValidatorState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              CosTextfield(
                focusNode: _textfieldStateMap[_firstName]?.focusNode,
                editingController: _textfieldStateMap[_firstName]?.controller,
                label: 'First name',
                onChanged:
                    (value) =>
                        _validatorBloc?.add(FirstNameValidationEvent(value)),
                error:
                    _textfieldStateMap[_firstName]?.focusNode.hasFocus == true
                        ? state.firstNameError
                        : null,
              ),
              CosTextfield(
                focusNode: _textfieldStateMap[_lastName]?.focusNode,
                editingController: _textfieldStateMap[_lastName]?.controller,
                label: 'Last name',
                onChanged:
                    (value) =>
                        _validatorBloc?.add(LastNameValidationEvent(value)),
                error:
                    _textfieldStateMap[_lastName]?.focusNode.hasFocus == true
                        ? state.lastNameError
                        : null,
              ),
              CosTextfield(
                focusNode: _textfieldStateMap[_email]?.focusNode,
                editingController: _textfieldStateMap[_email]?.controller,
                label: 'Email',
                onChanged:
                    (value) => _validatorBloc?.add(EmailValidationEvent(value)),
                error:
                    _textfieldStateMap[_email]?.focusNode.hasFocus == true
                        ? state.emailError
                        : null,
              ),
              CosTextfield(
                focusNode: _textfieldStateMap[_password]?.focusNode,
                label: 'Password',
                onChanged:
                    (value) =>
                        _validatorBloc?.add(PasswordValidationEvent(value)),
                error:
                    _textfieldStateMap[_password]?.focusNode.hasFocus == true
                        ? state.passwordError
                        : null,
                obscureText: true,
              ),
              CosTextfield(
                focusNode: _textfieldStateMap[_repeatPassword]?.focusNode,
                label: 'Repeat Password',
                onChanged:
                    (value) => _validatorBloc?.add(
                      RepeatedPasswordValidationEvent(value),
                    ),
                error:
                    _textfieldStateMap[_repeatPassword]?.focusNode.hasFocus ==
                            true
                        ? state.repeatPasswordError
                        : null,
                obscureText: true,
              ),
              BlocSelector<RegisterBloc, BlocBaseCommonState, bool>(
                selector: (state) {
                  return state is RememberMeState && state.shouldStayLoggedIn;
                },
                builder: (context, shouldStayLoggedIn) {
                  return GestureDetector(
                    onTap:
                        () => _registerBloc?.add(
                          RememberMeEvent(!shouldStayLoggedIn),
                        ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: shouldStayLoggedIn,
                          onChanged: (bool? value) {
                            _registerBloc?.add(RememberMeEvent(value ?? false));
                          },
                        ),
                        Text('Stay logged in'),
                      ],
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed:
                    state.isValid
                        ? () => _registerBloc?.add(
                          RegisterEvent(
                            _getText(_firstName),
                            _getText(_lastName),
                            _getText(_email),
                          ),
                        )
                        : null,
                child: Text('Register'),
              ),
              _listenToSuccess(),
            ],
          ),
        );
      },
    );
  }

  Widget _listenToSuccess() {
    return BlocListener<RegisterBloc, BlocBaseCommonState>(
      listener: (context, state) {
        if (state is LocalSuccessState && state.isSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ModuleConfigurator(context).configureVINPage(),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  String? _getText(String key) => _textfieldStateMap[key]?.controller?.text;
}
