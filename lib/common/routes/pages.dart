import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/application_page.dart';
import 'package:ulearning_app/pages/application/bloc/app_bloc.dart';
import 'package:ulearning_app/pages/home/home_page.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_blocs.dart';
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
        page: const ApplicationPage(),
        bloc: BlocProvider(create: (_) => AppBloc()),
      ),    
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: const HomePage(),
        bloc: BlocProvider(create: (_) => HomePageBlocs()),
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
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();

          // We check user booted up our app or not 
          if(result.first.route == AppRoutes.INITIAL && deviceFirstOpen){

            // and then check user ever loggin or not 
            bool isLoggedIn = Global.storageService.getIsLoggedIn();
            if(isLoggedIn){ 
              return MaterialPageRoute(builder: (_)=> const ApplicationPage(), settings: settings);
            }

            // if user didn't loginn to go sign in page
            return  MaterialPageRoute(builder: (_) => const SignIn(), settings: settings);
          }

        // if user never open it go to onboarding screen
        return MaterialPageRoute(builder: (_)=> result.first.page, settings: settings);
      }else{
        print('Hendie - result is empty : $result');
      }

    }else{
      print('Hendie - settings.name is null : ${settings.name}');
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