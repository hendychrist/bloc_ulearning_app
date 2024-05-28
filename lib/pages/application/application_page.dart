// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/application/application_widget.dart';
import 'package:ulearning_app/pages/application/bloc/app_bloc.dart';
import 'package:ulearning_app/pages/application/bloc/app_events.dart';
import 'package:ulearning_app/pages/application/bloc/app_states.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {

        if (state == null) {
          return Center(child: Text('application_page.dart\nInvalid State'));
        }

        return Container(
          color: Colors.pink,
          child: SafeArea(
            child: Scaffold(
              body: buildPage(state.index),
              bottomNavigationBar: Container(
                                      width: 375.w,
                                      height: 58.h,
                                      decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                                        topLeft: Radius.circular(20.h),
                                                                        topRight: Radius.circular(20.h)
                                                                    ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.1),
                                                          spreadRadius: 1,
                                                          blurRadius: 1,
                                                        )
                                                      ]
                                                    ),
        
                                      child: BottomNavigationBar(
                                                              currentIndex: state.index,
                                                              type: BottomNavigationBarType.fixed,
                                                              elevation: 0,
                                                              showSelectedLabels: false,
                                                              showUnselectedLabels: false,
                                                              selectedItemColor: AppColors.primaryElement,
                                                              unselectedItemColor: AppColors.primaryFourElementText,
                                                              onTap: (value){
                                                                context.read<AppBloc>().add(TriggerAppEvent(value));
                                                              },
                                                              items: bottomTabs,
                                     
                                      ),       
              ),
            ),
          ),
        );
      }
    );
  }
}