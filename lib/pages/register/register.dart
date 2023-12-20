import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/common_widget.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_events.dart';
import 'package:ulearning_app/pages/register/bloc/register_states.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {

        return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: buildAppBar("Sign Up"),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            
                            SizedBox(
                              height: 20.h,
                            ),
                                    
                            reusableText("Enter your details below & free sign up"),
                            Container(
                              margin: EdgeInsets.only(top: 36.h), 
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    
                                  reusableText('Username'),
                                  buildTextField(
                                    "Enter Your Username",
                                     "name", 
                                     "user", 
                                    (value){
                                       context.read<RegisterBloc>().add(UsernameEvent(value));
                                    } 
                                  ),
                                    
                                  reusableText('Email'),
                                  buildTextField(
                                    "Enter Your Email Address",
                                     "email", 
                                     "user", 
                                    (value){
                                      context.read<RegisterBloc>().add(EmailEvent(value));
                                    } 
                                  ),
                                  
                                  reusableText('Password'),
                                  buildTextField(
                                    "Enter Your password",
                                    "password",
                                    "lock",
                                    (value){
                                      context.read<RegisterBloc>().add(PasswordEvent(value));
                                    } 
                                  ),
                                    
                                  reusableText('Confirm password'),
                                  buildTextField(
                                    "Re-enter your password to confirm",
                                     "password", 
                                     "lock", 
                                    (value){
                                      context.read<RegisterBloc>().add(ConfirmPasswordEvent(value));
                                    } 
                                  ),
                                    
                                  reusableText("Enter your details below & free sign up"),
                                  
                                  buildLogInAndRegButton(
                                    'Sign Up',
                                    'register',
                                     (){
                                      Navigator.of(context).pushNamed("register");
                                    }
                                  ),
                                  
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            );
          }
        );
      
  
  }


}