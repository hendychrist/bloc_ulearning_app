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

  Future<void> handleSignIn(String type) async {
    try{ 
      if(type == "email"){

        // final state = BlocProvider.of<SignInBloc>(context).state; // same way
        final state = context.read<SignInBloc>().state; // same way

        String emailAddress = state.email;
        String password = state.password;

        if(emailAddress.isEmpty){
          toastInfo(msg: "You need to fill Email Address");
          return;
        }else{
          debugPrint('email is $emailAddress');
        }

        if( password.isEmpty){
           toastInfo(msg: "You need to fill Password");
           return;
        }else{
           debugPrint('password is $password');
        }
        
        try{

          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);

            if(credential.user == null){
              toastInfo(msg: "User doesn't exis");
              return;
            }
 
            if(!credential.user!.emailVerified){
              toastInfo(msg: "You need to verify your email account");
              return;
            }

          var user = credential.user;

            if(user != null){
              toastInfo(msg: "User exist");
              print('user exst');
              return;
            }else{ 
              toastInfo(msg: "No User");
              print('no user');
              return;
            }
 
        }on FirebaseAuthException catch (e){

          if(e.code == 'user-not-found'){ 
            toastInfo(msg: "No user found for that email");
          }else if(e.code == 'wrong-password'){
            toastInfo(msg: "Wrong password provided for that user");
          }else if(e.code == 'invalid-email'){
            toastInfo(msg: "Your email address format is wrong");
          }else{
            toastInfo(msg: "${e.message}");
          }

          debugPrint("hendie - ");
          debugPrint("hendie - e : $e");
          debugPrint("hendie - code : ${e.code}");
          debugPrint("hendie - message : ${e.message}"); 
          debugPrint("hendie - credential : ${e.credential}"); 
          debugPrint("hendie - ");

          debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get credential : $e');
        }

      }

    }catch(e){
      debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get state of SignInBloc : $e');
    }

  }
}