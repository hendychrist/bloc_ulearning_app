import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/register/register.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/welcome_ui.dart';

class AppPages{

   static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const WelcomeUI(),
        bloc: BlocProvider<WelcomeBlocs>(create: (_) => WelcomeBlocs()),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider<SignInBloc>(create: (_) => SignInBloc()),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: const Register(),
        bloc: BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),
      ),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const WelcomeUI(),
      ),
    ];
  }

  static List<BlocProvider> allBlocProviders(BuildContext context) {
    List<BlocProvider> blocProviders = <BlocProvider>[];

    for (var blocEntity in routes()) {
      if (blocEntity.bloc != null) {
        blocProviders.add(blocEntity.bloc);
      }
    }

    return blocProviders;
  }

  // a modal that covers entire screen as we click on navigator object 
  static MaterialPageRoute generateRouteSettings(RouteSettings settings){
    if(settings.name != null){



      // check for route name matching when navigator gets trigerred
      var result = routes().where((element) => element.route == settings.name);

      if(result.isNotEmpty){
        print('Hendie - valid route name ${settings.name}');
        return MaterialPageRoute(builder: (_)=> result.first.page, settings: settings);
      }
    }

  print('Hendie - invalid route name ${settings.name}');
   return MaterialPageRoute(builder: (_) => const SignIn(), settings: settings );
  }
} 

// unify blocProvider and route and page
class PageEntity{
  String route;
  Widget page;
  dynamic bloc;

    // Constructor
    PageEntity({
      required this.route, 
      required this.page,
      this.bloc
    });

}