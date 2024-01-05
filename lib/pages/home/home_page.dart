// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Container(
                color: Colors.cyan,
                child: Column(    
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: Text( 
                              'Hello',
                              style: TextStyle(
                                color: AppColors.primaryThirdElementText,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      child: Text(
                              'Hendy',
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                    )

                  ],
                ),
                
              ),
      ),
    );

  }
}