import 'package:car_on_sale_challenge/presentation_layer/register/user_validation_events/form_validation_event.dart';

class PasswordValidationEvent extends FormValidationEvent {
  String password;
  PasswordValidationEvent(this.password);
}
