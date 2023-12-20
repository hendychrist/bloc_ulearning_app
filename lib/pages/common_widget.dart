// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

AppBar buildAppBar(String type){
  return AppBar(
            centerTitle: true,
            title: Text(
                    "$type",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal
                    ),
                  ),

            bottom: PreferredSize(
                        preferredSize: Size.fromHeight(1.0),
                        child: Container(
                                  height: 1.0,
                                  color: AppColors.primarySecondaryBackground,
                                ),
                      ),

      );
}

Widget buildThirdPartyLogin(BuildContext ctx){
  return Container(
    // margin: EdgeInsets.only(top: 40.h, left: 20.h, bottom: 20.h),
    margin: EdgeInsets.only(top: 40.h, bottom: 20.h),
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
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
    margin: EdgeInsets.only(bottom: 5.h),
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

Widget buildTextField(String hintText, String textType, String iconName, void Function(String value)? func ){
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(15.w)),
                  border: Border.all(color: AppColors.primaryThirdElementText)
                ),
    child: Row(
      children: [

        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 17.w),
          child: Image.asset("assets/icons/$iconName.png"),
        ),

        SizedBox(
          width: 280.w,
          height: 50.h,
          child: TextField(
                  onChanged: (value) => func!(value),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                                hintText: hintText,
                                hintStyle: TextStyle(color: AppColors.primarySecondaryElementText),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),

                              ),
                  style: TextStyle(
                            color: AppColors.primaryText,
                            decorationColor: AppColors.primaryText,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp,
                          ),
                  autocorrect: false,
                  obscureText: textType == 'password' ? true : false,
          ),
        ),

      ],
    ),
  );
}

Widget forgotPassword(){
  return Container(
    width: 260.w,
    height: 44.h,
    // margin: EdgeInsets.only(left: 25.w),
    child: InkWell(
      onTap: (){

      },
      child: Text(
        "Forgot Password",
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
          fontSize: 12.sp,
          decorationColor: Colors.blue
        ),
      ),
    ),
  );
}

Widget buildLogInAndRegButton(String buttonName, String buttonType, void Function()? func){
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
                  top: buttonType == 'login' 
                        ? 
                          40.h 
                        : 
                          20.h
                ),
      padding: EdgeInsets.only(left: 25.w, right: 25.w,),
      alignment: Alignment.center,
      decoration: BoxDecoration(
                    color: buttonType == "login" 
                            ?
                              AppColors.primaryElement 
                            :
                              AppColors.primaryBackground,
                    border: Border.all(
                                color: buttonType == 'login' 
                                        ?
                                           Colors.transparent 
                                        :
                                           AppColors.primaryFourElementText
                              ),
                    borderRadius: BorderRadius.circular(15.w),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0,1),
                        color: AppColors.primarySecondaryBackground,
                      )
                    ],
                  ),
      child: Text(
      '$buttonName',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: buttonType == "login" 
                  ?
                     AppColors.primaryBackground 
                  :
                     AppColors.primaryText,
        ),
      ),
    ),
  );
}