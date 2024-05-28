import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
import 'package:ulearning_app/pages/application/bloc/app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState>{
     AppBloc() : super(const AppState()){

      on<TriggerAppEvent>((event, emit){
        print("APP_BLOC.dart - my tapped index is : ${event.index}");
        emit(AppState(index: event.index));
      });

    }
}