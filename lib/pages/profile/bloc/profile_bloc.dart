import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/entities/user.dart';

part 'profile_events.dart';
part 'profile_states.dart';

class ProfileBlocs extends Bloc<ProfileEvents, ProfileStates>{
   ProfileBlocs(): super(const ProfileStates()){
    on<TriggerProfileName>(_triggerProfileName);
  }

  _triggerProfileName(TriggerProfileName event, Emitter<ProfileStates> emit){
    emit(state.copyWith(userProfile: event.userProfile));
  }
}