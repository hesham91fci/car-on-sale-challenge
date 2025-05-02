import 'package:car_on_sale_challenge/presentation_layer/register/register_events/base_register_event.dart';

class RememberMeEvent extends BaseRegisterEvent {
  final bool shouldStayLoggedIn;
  RememberMeEvent(this.shouldStayLoggedIn);
}
