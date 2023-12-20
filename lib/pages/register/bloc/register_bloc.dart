// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_events.dart';
import 'package:ulearning_app/pages/register/bloc/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  RegisterBloc() :super( const RegisterState()){
        on<UsernameEvent>(_usernameEvent); 
        on<EmailEvent>(_emailEvent);
        on<PasswordEvent>(_passwordEvent);
        on<ConfirmPasswordEvent>(_confirmPasswordEvent);
    }

    void _usernameEvent(UsernameEvent event, Emitter<RegisterState> emit){
      debugPrint('${event.username}');
      emit(state.copyWith(email: event.username,));
    }

    void _emailEvent(EmailEvent event, Emitter<RegisterState> emit){
      debugPrint('${event.email}');
      emit(state.copyWith(password: event.email));
    }

     void _passwordEvent(PasswordEvent event, Emitter<RegisterState> emit){
      debugPrint('${event.password}');
      emit(state.copyWith(password: event.password));
    }

     void _confirmPasswordEvent(ConfirmPasswordEvent event, Emitter<RegisterState> emit){
      debugPrint('${event.confirmPassword}');
      emit(state.copyWith(password: event.confirmPassword));
    }

}