// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/routes/routes.dart';
import 'pages/application/bloc/app_bloc.dart';
import 'pages/application/bloc/app_states.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
              providers: [...AppPages.allBlocProviders(context)],
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
                            onGenerateRoute: AppPages.generateRouteSettings,
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
                  child: BlocBuilder<AppBloc, AppState>(
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
                                      "BlocProvider.of<AppBloc>(context).state.counter.toString(), ",
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
                                    // onPressed: () => BlocProvider.of<AppBlocs>(context).add(Decrement()),
                                    onPressed: null,
                                    tooltip: 'Decrement',
                                    child: const Icon(Icons.remove),
                                  ),
        
                                  FloatingActionButton(
                                    heroTag: 'heroTag2',
                                    // onPressed: () => BlocProvider.of<AppBlocs>(context).add(Increment()),
                                    onPressed: null,
                                    tooltip: 'Increment',
                                    child: const Icon(Icons.add),
                                  ),
                                  
                                ],
                              ),
      )

    );
 

  }
}
