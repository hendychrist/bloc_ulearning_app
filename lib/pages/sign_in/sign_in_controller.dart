// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';

class SignInController{
  final BuildContext context;

  const SignInController({required this.context});

  void handleSignIn(String type) async {
    try{ 
      if(type == "email"){

        // final state = BlocProvider.of<SignInBloc>(context).state; // same way
        final state = context.read<SignInBloc>().state; // same way

        String emailAddress = state.email;
        String password = state.password;

        if(emailAddress.isEmpty){
          debugPrint('DEBUG : Error - sign_in_controllert.dart -> handleSignIn() : emailAddress is empty ');
        }else{
          debugPrint('email is $emailAddress');
        }

        if( password.isEmpty){
           debugPrint('DEBUG : Error - sign_in_controllert.dart -> handleSignIn() : password is empty');
        }else{
           debugPrint('password is $password');
        }
        
        try{

          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);

            if(credential.user == null){
              print('user doesn\'t exist');
            }
 
            if(!credential.user!.emailVerified){
              print('not verified');
            }

          var user = credential.user;
            if(user != null){
              // we got verified user from firebase 
              print('user exst');

            }else{
              // we have error getting user from firebase 
              print('no user');
              
            }
 
        }on FirebaseAuthException catch (e){

          if(e.code == 'user-not-found'){
            print('No user found for that email');
          }else if(e.code == 'wrong-password'){
            print('Wrong password provided for that user');
          }else if(e.code == 'invalid-email'){
            print('Your email format is wrong');
          }

          debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get credential : $e');
        }

      }

    }catch(e){
      debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get state of SignInBloc : $e');
    }

  }
}