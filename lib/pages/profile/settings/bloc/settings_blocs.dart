import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_event.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_state.dart';

class SettingsBlocs extends Bloc<SettingsEvents, SettingsState>{
    SettingsBlocs() : super(const SettingsState()){
      on<TriggerSettingsEvents>(_triggerSettings);
    }

  _triggerSettings(SettingsEvents event, Emitter<SettingsState> emit){
    emit(SettingsState());
  }

}