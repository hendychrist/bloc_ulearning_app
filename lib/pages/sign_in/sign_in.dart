// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
                      ],
                    )
                  ),
          );
  }
}