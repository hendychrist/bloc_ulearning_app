import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
// import 'package:ulearning_app/app_blocs.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';

class AppBlocProvider{
  static get allBlocProvider => [
      BlocProvider(create: (context) => WelcomeBlocs(),),
      // BlocProvider(create: (context) => AppBlocs(),),
      BlocProvider(create: (context) => SignInBloc(),),
      BlocProvider(create: (context) => RegisterBloc(),),
  ];
}