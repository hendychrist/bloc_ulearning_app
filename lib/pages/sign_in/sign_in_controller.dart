// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';

class SignInController{
  final BuildContext context;

  const SignInController({required this.context});

  //  Future<User> performSignIn(String email, String password) async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;

  //   UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
  //   final User? user = result.user;

  //   return user!;
  // }

  void handleSignIn(String type) async {
    try{ 
      if(type == "email"){

        // final state = BlocProvider.of<SignInBloc>(context).state; // same way
        final state = context.read<SignInBloc>().state; // same way

        String emailAddress = state.email;
        String password = state.password;

        if(emailAddress.isEmpty){
          toastInfo(msg: "You need to fill Email Address");
        }else{
          debugPrint('email is $emailAddress');
        }

        if( password.isEmpty){
           toastInfo(msg: "You need to fill Password");
        }else{
           debugPrint('password is $password');
        }
        
        try{

          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);

            if(credential.user == null){
              toastInfo(msg: "User doesn't exis");
              // print('user doesn\'t exist');
            }
 
            if(!credential.user!.emailVerified){
              toastInfo(msg: "You need to verify your email account");
              // print('not verified');
            }

          var user = credential.user;
          
          debugPrint("hendie - user : $user ");

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
            toastInfo(msg: "Your email address format is wrong");
          }

          debugPrint("hendie - ");
          debugPrint("hendie - e : $e");
          debugPrint("hendie - e : ${e.code}");
          debugPrint("hendie - e : ${e.message}"); 
          debugPrint("hendie - e : ${e.credential}"); 
          debugPrint("hendie - e : ${e.email}"); 
          debugPrint("hendie - ");

          debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get credential : $e');
        }

      }

    }catch(e){
      debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get state of SignInBloc : $e');
    }

  }
}