

import 'package:flutter/material.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/global.dart';

class HomeController{
  final BuildContext context;
  HomeController({required this.context});
  UserItem userProfile = Global.storageService.getUserProfile();

  Future<void> init() async {
    await CourseAPI.courseList();
    print("userProfile : ${userProfile.name}");
  }

}