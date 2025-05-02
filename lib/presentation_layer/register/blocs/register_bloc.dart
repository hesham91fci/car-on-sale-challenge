import 'package:car_on_sale_challenge/presentation_layer/common/local_success_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_events/register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, LocalSuccessState> {
  RegisterBloc() : super(const LocalSuccessState(false)) {
    on<RegisterEvent>((event, emit) {
      emit(LocalSuccessState(true));
    });
  }
}
