// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(){
  return AppBar(
            title: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal
                    ),
                  ),

            bottom: PreferredSize(
                        preferredSize: Size.fromHeight(1.0),
                        child: Container(
                                  height: 1.0,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                      ),

      );
}

Widget buildThirdPartyLogin(BuildContext ctx){
  return Container(
    margin: EdgeInsets.only(top: 40.h, left: 20.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _reusableIcon("google"),
        _reusableIcon("apple"),
        _reusableIcon("facebook"),
      ],
    )
  );
}

Widget _reusableIcon(String iconname){
  return GestureDetector(
    onTap: (){},
     child: SizedBox(
        width: 40.w,
        height: 40.w,
        child: Image.asset("assets/icons/$iconname.png"),
      ),
  );
}

Widget reusableText(String text){
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.5),
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
      ),
    ),
  );
}