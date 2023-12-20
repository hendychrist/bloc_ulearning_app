// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/app_blocs.dart';
import 'package:ulearning_app/app_events.dart';
import 'package:ulearning_app/app_state.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/bloc_providers.dart';
import 'package:ulearning_app/pages/register/register.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';
import 'package:ulearning_app/pages/welcome/welcome_ui.dart';
// import 'package:ulearning_app/app_state.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
              providers: AppBlocProvider.allBlocProvider,
              child: ScreenUtilInit(
                        builder: (context, child) {
                          return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            theme: ThemeData(
                              appBarTheme: AppBarTheme(
                                iconTheme: IconThemeData(color: AppColors.primaryText),
                                elevation: 0,
                                backgroundColor: Colors.white,
                              )
                            ),
                            home: WelcomeUI(),
                            routes: {
                              // "/myHomePage": (context) => const MyHomePage(),
                              "/signIn": (context) => const SignIn(),
                              "/register": (context) => const Register(),
                            },
                          );
                        },
                      ),

          );

  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("BLOC HOME PAGE"),
      ),

      body:   Center(
                  child: BlocBuilder<AppBlocs, AppStates>(
                    builder: (context, state) {
                      return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'You have pushed the button this many times:',
                                    ),
                                    Text(
                                      // '$_counter',
                                      BlocProvider.of<AppBlocs>(context).state.counter.toString(), 
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                  ],
                                );
                    }
                  ),
                ),
      
      floatingActionButton: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Row( 
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  FloatingActionButton(
                                    heroTag: 'heroTag1',
                                    onPressed: () => BlocProvider.of<AppBlocs>(context).add(Decrement()),
                                    tooltip: 'Decrement',
                                    child: const Icon(Icons.remove),
                                  ),
        
                                  FloatingActionButton(
                                    heroTag: 'heroTag2',
                                    onPressed: () => BlocProvider.of<AppBlocs>(context).add(Increment()),
                                    tooltip: 'Increment',
                                    child: const Icon(Icons.add),
                                  ),
                                  
                                ],
                              ),
      )

    );
 

  }
}
