import 'package:car_on_sale_challenge/base/bloc/bloc_base_common_state.dart';

final class RememberMeState extends BlocBaseCommonState {
  final bool shouldStayLoggedIn;
  RememberMeState(this.shouldStayLoggedIn);
}
