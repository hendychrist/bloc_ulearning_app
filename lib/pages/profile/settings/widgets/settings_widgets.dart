// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

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

Widget settingsButton(BuildContext context, VoidCallback func ){
  return   GestureDetector(
                      onTap: (){
                        
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Confirm logout"),
                              content: Text("Confirm Logout"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                     child: Text("Cancel")
                                    ),
                                TextButton(
                                  onPressed: () => func(),
                                  child: Text("Confirm")
                                )
                              ],
                            );
                          }
                        );  

                      },
                      child: Container(
                        height: 100.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              "assets/icons/Logout.png"
                            )
                          )
                        ),
                      ),
                    );

}