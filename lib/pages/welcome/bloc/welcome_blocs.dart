import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_events.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_states.dart';

class WelcomeBlocs extends Bloc<WelcomeEvents, WelcomeState>{
    WelcomeBlocs(): super(WelcomeState()){

      on<WelcomeEvents>((event, emit){
        emit(WelcomeState(page: state.page));
      });

    }
}