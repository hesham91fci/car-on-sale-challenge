import 'package:car_on_sale_challenge/base/bloc/bloc_base_common_state.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/user.dart';
import 'package:car_on_sale_challenge/data_access_layer/local_storage/local_starage_manager.dart';
import 'package:car_on_sale_challenge/data_access_layer/local_storage/record_name.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/local_success_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_events/base_register_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_events/register_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_events/remember_me_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_state/remember_me_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<BaseRegisterEvent, BlocBaseCommonState> {
  RememberMeEvent? _currentRememberMeEvent;
  RegisterBloc() : super(LocalSuccessState(false)) {
    on<RegisterEvent>((event, emit) async {
      if (_currentRememberMeEvent?.shouldStayLoggedIn == true) {
        await LocalStorageManager.shared.save(
          RecordName.currentUser,
          User(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
          ).toJson(),
        );
      }
      emit(LocalSuccessState(true));
    });
    on<RememberMeEvent>((event, emit) async {
      _currentRememberMeEvent = event;
      emit(RememberMeState(event.shouldStayLoggedIn));
    });
  }
}
