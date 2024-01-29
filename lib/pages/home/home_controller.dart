

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';

class HomeController{
  final BuildContext context;
  HomeController({required this.context});
  UserItem userProfile = Global.storageService.getUserProfile();

  Future<void> init() async {

    // make sure that user is logged in and then make an api call
    if(Global.storageService.getUserToken().isNotEmpty){
        var result = await CourseAPI.courseList();

        if(result.code == 200){ 
          if(result.data == null || result.data!.isEmpty){
            toastInfo(msg: 'home_controller.dart - result.data is Empty');
          }else{
            if(context.mounted){
              context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
            }else{
              toastInfo(msg: 'home_controller.dart -> 38 -> context not mounted');
            }
          }
        }else{
          debugPrint('Hendie - ${result.code}');
        }
    }else{
      print('User has already log out');
    }

  }

}