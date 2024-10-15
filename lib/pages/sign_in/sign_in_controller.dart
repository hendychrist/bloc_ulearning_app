// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ulearning_app/common/apis/user_api.dart';
// import 'package:ulearning_app/common/apis/user_api.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';

class SignInController{
  final BuildContext context; 

  SignInController({required this.context});
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

              if(context.mounted){
                 HomeController(context: context).init();
              }

              await asyncPostAllData(loginRequestEntity);

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

      if(type == "google"){
        try{
          final user = await _googleSignIn.signIn();

            if(user == null){
              toastInfo(msg: "User doesn't exist");
              return 'User doesn\'t exist';
            }

              // Create a model from below information to database. and we should send json object
              String? displayName = user.displayName;
              String? email = user.email;
              String? id = user.id;
              String? photoUrl = user.photoUrl ?? "${AppConstants.SERVER_API_URL}uploads/default.png";

              debugPrint("DEBUG: Google SignIn - photoUrl : ${user.photoUrl}");

              // Input value to model 
              LoginRequestEntity loginRequestEntity = LoginRequestEntity();
              
              loginRequestEntity.avatar = photoUrl;
              loginRequestEntity.name = displayName;
              loginRequestEntity.email = email;
              loginRequestEntity.open_id = id;

              // type one is email login 
              loginRequestEntity.type = 2;

              if(context.mounted){
                 HomeController(context: context).init();
              }

              await asyncPostAllData(loginRequestEntity);

              // return 'user exist';
         
 
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

        }
      }

      return 'Unexpected error occurred during sign-in.';
    }catch(e){
      debugPrint('DEBUG: ERROR - sign_in_controller.dart - handleSignIn() -> when get state of SignInBloc : $e');
      return 'DEBUG: ERROR - TRY CATCH $e';
    }

  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
  var result = await UserAPI.login(params: loginRequestEntity);

  String returnAccessToken = result.data!.access_token.toString();
  print("Hendie - returnAccessToken : ${result.data!.access_token}");

  if (result.code == 200) {
    try {
      Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data));

      print('......my token is | ${result.data!.access_token!}.......');

      // used for authorization, that's why we save it.
      Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY, returnAccessToken);

      EasyLoading.dismiss();

      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);
      } else {
        toastInfo(msg: 'sign_in_controller.dart -> 154 -> context not mounted');
      }
    } catch (e) {
      debugPrint('Saving local storage error : $e');
    }
  } else {
    EasyLoading.dismiss();
    toastInfo(msg: "UserAPI.login return != 200");
  }
}


}