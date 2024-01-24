// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/common_widget.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_events.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_state.dart';
import 'package:ulearning_app/pages/sign_in/sign_in_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {

        return Scaffold(
                backgroundColor: Colors.white,
                appBar: buildAppBar("Log In"),
                body: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildThirdPartyLogin(context),
                            reusableText("Or use your email account login"),
                            Container(
                              margin: EdgeInsets.only(top: 56.h), 
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  reusableText('Email'),
                                  SizedBox(height: 5.h),

                                  AbsorbPointer(
                                    absorbing: state.isLoading,
                                    child: buildTextField(
                                      "Enter Your Email Address",
                                       "email", 
                                       "user", 
                                      (value){
                                        context.read<SignInBloc>().add(EmailEvent(value));
                                      },
                                    ),
                                  ),
        
                                  reusableText('Password'),
                                  SizedBox(height: 5.h),

                                  AbsorbPointer(
                                    absorbing: state.isLoading,
                                    child: buildTextField(
                                      "Enter Your password",
                                      "password",
                                      "lock",
                                      (value){
                                        context.read<SignInBloc>().add(PasswordEvent(value));
                                      },
                                    ),
                                  ),
                                  
                                  forgotPassword(),
                                  SizedBox(height: 70.h),

                                  buildLogInAndRegButton(
                                      text: 'Log In',
                                      isLoading: state.isLoading,
                                      onTap: () async {

                                          // Show loading 
                                          EasyLoading.show(
                                            indicator: CircularProgressIndicator(),
                                            maskType: EasyLoadingMaskType.clear,
                                            dismissOnTap: true
                                          );

                                          context.read<SignInBloc>().add(IsLoadingEvent(true));

                                          SignInController(context: context).handleSignIn("email").then((value) => {

                                                                        if(value == 'user exist'){
                                                                          Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false),
                                                                        }else
                                                                          context.read<SignInBloc>().add(IsLoadingEvent(false)),
                                                                      });
                                      },
                                    ),

                                    buildLogInAndRegButton(
                                      text: 'Register',
                                      isLoading: false,
                                      onTap: () {
                                        Navigator.of(context).pushNamed("/register");
                                      }, 
                                    ),


                                ],
                              ),
                            )
                          ],
                        )
                      ),
              );
      }
    );
  
  }

}