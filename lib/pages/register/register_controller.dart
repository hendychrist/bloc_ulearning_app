 // ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';

class RegisterController{
    final BuildContext context;
    const RegisterController({required this.context});


    Future<void> handleEmailRegister() async {
      final state = context.read<RegisterBloc>().state;

      String username = state.username;
      String email = state.email;
      String password = state.password;
      String confirmPassword = state.confirmPassword;

      if(username.isEmpty){
        toastInfo(msg: "Username cannot be empty");
        return; 
      }
      
      if(email.isEmpty){
        toastInfo(msg: "Email cannot be empty");
        return; 
      }

      if(password.isEmpty){
        toastInfo(msg: "Password cannot be empty");
        return; 
      }

      if(confirmPassword.isEmpty){
        toastInfo(msg: "Confirm Password cannot be empty");
        return; 
      }
      
      try{
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        if(credential.user != null){
          await credential.user?.sendEmailVerification(); 
          await credential.user?.updateDisplayName(username);

          String photoUrl = "uploads/default.png";
          await credential.user?.updatePhotoURL(photoUrl);

          EasyLoading.dismiss();

          toastInfo(msg: "An email has been send to your registered email. To active it please check your email box and click ont he link");
          Navigator.of(context).pop();
      }

      }on FirebaseAuthException catch(e){
          if(e.code == 'weak-password'){ 
            toastInfo(msg: "The password provided is to weak");
          }else if(e.code == 'email-already-in-use'){ 
            toastInfo(msg: "The email is already in use");
          }else if(e.code == 'invalid-email'){
            toastInfo(msg: "Your email address format is wrong");
          }else{
            toastInfo(msg: "${e.message}");
          }
      }


    }
 }