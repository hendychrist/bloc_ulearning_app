// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/bloc/app_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
import 'package:ulearning_app/pages/common_widget.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_state.dart';
import 'package:ulearning_app/pages/profile/settings/widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Future<void> removeUserData() async {
    context.read<AppBloc>().add(const TriggerAppEvent(0));
    context.read<HomePageBlocs>().add(const HomePageDots(0));

    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Settings'),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBlocs, SettingsState>(
          builder: (context, state){

            if (state == null) {
              return Center(child: Text('settings_page.dart\nInvalid State'));
            }

            return Container(
              color: Colors.white,
              height: 712.h,
              child: Center(child: settingsButton(context, removeUserData)),
            );

          },
        ),
      ),
    );
  }
}