

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
  late BuildContext context;

  // getter to directly call userprofile
  UserItem get userProfile => Global.storageService.getUserProfile(); 

  static final HomeController _singelton = HomeController._internal();
  HomeController._internal();

  // this is a factory constructor - make sure you have the original only one instance
  factory HomeController({required BuildContext context}){
    _singelton.context = context;
    return _singelton; 
  }

  Future<void> init() async {
    // make sure that user is logged in and then make an api call
    if(Global.storageService.getUserToken().isNotEmpty){
        var result = await CourseAPI.courseList();
        
        if(result.code == 200){ 
          if(result.data == null || result.data!.isEmpty){
            toastInfo(msg: 'home_controller.dart - result.data is Empty');
          }else{
            print('Hendie - the result is ${result.data}');

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