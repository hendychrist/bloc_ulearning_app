// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/widget/sign_in_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(),
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
                              buildTextField("Enter Your Email Address", "email", "user"),

                              reusableText('Password'),
                              SizedBox(height: 5.h),
                              buildTextField("Enter Your password", "password", "lock"),
                              
                              forgotPassword(),
                              buildLogInAndRegButton('Log In', 'login'),
                              buildLogInAndRegButton('Register', 'register'),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
          );
  }
}