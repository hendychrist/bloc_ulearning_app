// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/apis/user_api.dart';
// import 'package:ulearning_app/common/apis/user_api.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
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

  Future<String> handleSignIn(String type) async {
    try{ 
      if(type == "email"){

        // final state = BlocProvider.of<SignInBloc>(context).state; // same way
        final state = context.read<SignInBloc>().state; // same way 

        String emailAddress = state.email;
        String password = state.password;

        if(emailAddress.isEmpty){
          toastInfo(msg: "You need to fill Email Address");
          return 'You need to fill Email Address';
        }else{
          debugPrint('email is $emailAddress');
        }

        if( password.isEmpty){
           toastInfo(msg: "You need to fill Password");
           return 'You need to fill Password';
        }else{
           debugPrint('password is $password');
        }
        
        try{

          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);

            if(credential.user == null){
              toastInfo(msg: "User doesn't exist");
              return 'User doesn\'t exist';
            }
 
            if(!credential.user!.emailVerified){
              toastInfo(msg: "You need to verify your email account");
              return 'You need to verify your email account';
            }

          var user = credential.user;

            if(user != null){
              toastInfo(msg: "User exist");

              // Create a model from below information to database. and we should send json object
              String? displayName = user.displayName;
              String? email = user.email;
              String? id = user.uid;
              String? photoUrl = user.photoURL;

              // Input value to model 
              LoginRequestEntity loginRequestEntity = LoginRequestEntity();
              loginRequestEntity.avatar = photoUrl;
              loginRequestEntity.name = displayName;
              loginRequestEntity.email = email;
              loginRequestEntity.open_id = id;

              // type one is email login 
              loginRequestEntity.type = 1;

              asyncPostAllData(loginRequestEntity);
              
              // return 'user exist';
            }else{ 
              toastInfo(msg: "No User");
              
              return 'No User';
            }
 
        }on FirebaseAuthException catch (e){

          if(e.code == 'user-not-found'){ 
            toastInfo(msg: "No user found for that email");
            return 'No user found for that email';
          }else if(e.code == 'wrong-password'){
            toastInfo(msg: "Wrong password provided for that user");
            return 'Wrong password provided for that user';
          }else if(e.code == 'invalid-email'){
            toastInfo(msg: "Your email address format is wrong");
            return 'Your email address format is wrong';
          }else{
            toastInfo(msg: "${e.message}");

            print('DEBUG: ERROR : on FirebaseAuthException catch (e)');
            print('DEBUG: ${e.message}');

            return '${e.message}';
          }

          // debugPrint("hendie - ");
          // debugPrint("hendie - e : $e");
          // debugPrint("hendie - code : ${e.code}");
          // debugPrint("hendie - message : ${e.message}"); 
          // debugPrint("hendie - credential : ${e.credential}"); 
          // debugPrint("hendie - ");

          // debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get credential : $e');
        }
      }
      return 'Unexpected error occurred during sign-in.';
    }catch(e){
      debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get state of SignInBloc : $e');
      return 'DEBUG: ERROR - TRY CATCH $e';
    }

  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) async {

    var result = await UserAPI.login(params: loginRequestEntity);
    debugPrint('Hendie - result : $result');

    if(result.code == 200){

      try{
        Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data));
        Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, "12345678");
        EasyLoading.dismiss();
        Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
      }catch(e){
        debugPrint('Saving local storage error : ');
      }

    }else{
      EasyLoading.dismiss();
      toastInfo(msg: "UserAPI.login return != 200");
    }

  }

}