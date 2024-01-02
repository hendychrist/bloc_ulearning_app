// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
        return Container(
          color: Colors.pink,
          child: SafeArea(
            child: Scaffold(
              body: buildPage(index),
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
                                                              currentIndex: index,
                                                              type: BottomNavigationBarType.fixed,
                                                              elevation: 0,
                                                              showSelectedLabels: false,
                                                              showUnselectedLabels: false,
                                                              selectedItemColor: AppColors.primaryElement,
                                                              unselectedItemColor: AppColors.primaryFourElementText,
                                      
                                                              onTap: (value){

                                                                context.read<AppBloc>().add(TriggerAppEvent(value));
                                                            
                                                              },
                                                              items: [
                                      
                                                                BottomNavigationBarItem(
                                                                  label: "home",
                                                                  icon: SizedBox(
                                                                      width: 15.w,
                                                                      height: 15.h,
                                                                      child: Image.asset("assets/icons/home.png"),
                                                                  ),
                                                                  activeIcon: SizedBox(
                                                                                width: 15.w,
                                                                                height: 15.h,
                                                                                child: Image.asset(
                                                                                          "assets/icons/home.png",
                                                                                          color: AppColors.primaryElement,
                                                                                        ),
                                                                              )
                                                                ),
                                      
                                                              BottomNavigationBarItem(
                                                                  label: "search",
                                                                  icon: SizedBox(
                                                                      width: 15.w,
                                                                      height: 15.h,
                                                                      child: Image.asset("assets/icons/search2.png"),
                                                                  ),
                                                                  activeIcon: SizedBox(
                                                                                width: 15.w,
                                                                                height: 15.h,
                                                                                child: Image.asset(
                                                                                          "assets/icons/search2.png",
                                                                                          color: AppColors.primaryElement,
                                                                                        ),
                                                                              )
                                                                ),
                                      
                                                                BottomNavigationBarItem(
                                                                  label: "course",
                                                                  icon: SizedBox(
                                                                      width: 15.w,
                                                                      height: 15.h,
                                                                      child: Image.asset("assets/icons/play-circle1.png"),
                                                                  ),
                                                                  activeIcon: SizedBox(
                                                                                width: 15.w,
                                                                                height: 15.h,
                                                                                child: Image.asset(
                                                                                          "assets/icons/play-circle1.png",
                                                                                          color: AppColors.primaryElement,
                                                                                        ),
                                                                              )
                                                                ),
                                      
                                                                BottomNavigationBarItem(
                                                                  label: "chat",
                                                                  icon: SizedBox(
                                                                      width: 15.w,
                                                                      height: 15.h,
                                                                      child: Image.asset("assets/icons/message-circle.png"),
                                                                  ),
                                                                  activeIcon: SizedBox(
                                                                                width: 15.w,
                                                                                height: 15.h,
                                                                                child: Image.asset(
                                                                                          "assets/icons/message-circle.png",
                                                                                          color: AppColors.primaryElement,
                                                                                        ),
                                                                              )
                                                                ),
                                      
                                                                BottomNavigationBarItem(
                                                                  label: "profile",
                                                                  icon: SizedBox(
                                                                      width: 15.w,
                                                                      height: 15.h,
                                                                      child: Image.asset("assets/icons/person2.png"),
                                                                  ),
                                                                  activeIcon: SizedBox(
                                                                                width: 15.w,
                                                                                height: 15.h,
                                                                                child: Image.asset(
                                                                                          "assets/icons/person2.png",
                                                                                          color: AppColors.primaryElement,
                                                                                        ),
                                                                              )
                                                                ),
                                      
                                                              ],
                                                            
                                      ),
                                  
              ),
            ),
          ),
        );
      }
    );
  }
}