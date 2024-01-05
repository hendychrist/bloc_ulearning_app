
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(){
  return AppBar( 
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        
        Container(
          width: 15.w,
          height: 12.h,
          color: Colors.yellow,
          child: Image.asset("assets/icons/menu.png"),
        ),

        GestureDetector(
          onTap: (){},
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
                          color: Colors.pink,
                          image: DecorationImage(
                                    image: AssetImage(
                                                "assets/icons/person.png"
                                              )
                                  )
                        ),
          ),
        ),

      ],
    ),
  );
} 