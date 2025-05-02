import 'package:car_on_sale_challenge/presentation_layer/register/register_events/base_register_event.dart';

class RegisterEvent extends BaseRegisterEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  RegisterEvent(this.firstName, this.lastName, this.email);
}
