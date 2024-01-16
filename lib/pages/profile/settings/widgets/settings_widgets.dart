// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

AppBar buildAppBarSettings(){
  return AppBar(
    centerTitle: true,
    title: Container(
      child: Text(
        "Settings",
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp
        ),
      ),
    ),
  );
}
