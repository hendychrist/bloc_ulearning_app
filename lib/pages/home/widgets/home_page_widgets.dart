
// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_events.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_states.dart';

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

// reusable big text widget
Widget homePageText(String text, {Color? color = AppColors.primaryText, int top = 20, int bot = 0}){
    return  Container(
                      margin: EdgeInsets.only(top: top.h, bottom: bot.h),
                      child: Text(
                              text,
                              style: TextStyle(
                                color: color,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                    );
                        
}

Widget searchView(){
  return Row(
    children: [

      Container(
          width: 280.w,
          height: 40.h,
          decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        borderRadius: BorderRadius.circular(13.h),
                        border: Border.all(color: AppColors.primaryFourElementText)
                      ),
            child: Row(
              children: [
      
                  Container(
                    width: 16.w,
                    height: 16.h,
                    margin: EdgeInsets.only(left: 17.w),
                    child: Image.asset("assets/icons/search.png"),
                  ),
      
                  Container(
                    width: 240.w,
                    height: 40.h,
                    
                      child: TextField(
                              // onChanged: (value) => func!(value),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                            hintText: "Search your course",
                                            hintStyle: TextStyle(color: AppColors.primarySecondaryElementText),
                                            contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                              obscureText: false,
                      ),
                
                  )
      
              ],
            ),
      ),
    
      GestureDetector(
        child: Container(
          width: 40.w, 
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.all(Radius.circular(13.w)),
            border: Border.all(color: AppColors.primaryElement),
          ),
          child: Image.asset("assets/icons/options.png"),
        ),
      )

    ],
  );
}

Widget slidersView(BuildContext context, HomePageStates state){
  return Column (
    children: [

      Container(
        width: 325.w,
        height: 160.h,
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 20.h),
        child: PageView(
          onPageChanged: (value){
            context.read<HomePageBlocs>().add(HomePageDots(value));
          },
          children: [
              _slidersContainer(path: "assets/icons/Art.png"),
              _slidersContainer(path: "assets/icons/Image(1).png"),
              _slidersContainer(path: "assets/icons/Image(2).png"),
          ],
        ),
      ),

      Container(
        child: DotsIndicator(
          dotsCount: 3,
          position: state.index,
          decorator: DotsDecorator(
            color: AppColors.primaryThirdElementText,
            activeColor: AppColors.primaryElement,
            size: const Size.square(5.0),
            activeSize: const Size(17.0, 5.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
          ),
        ),  
      ),

    ],
  );
}

Widget _slidersContainer({String path = "assets/icons/Art.png"}){
  return  Container(
              width: 325.w,
              height: 160.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.h)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(path)
                )
              ),
            );
}

Widget menuView(){
  return Column(
    children: [
 
      Container(
        width: 325.w,
        margin: EdgeInsets.only(top: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            _reusableText('Choose your course'),

            GestureDetector(
              onTap: (){},
              child: _reusableText('See all', color: AppColors.primaryThirdElementText, fontSize: 12)
            ),

          ],
        ),
      ),

      Container(
        margin: EdgeInsets.only(top: 20.w),
        child: Row(
          children: [
           _reusableMenuText(menuText: "All", backgroundColor: Colors.transparent, textColor: AppColors.primaryThirdElementText),
           _reusableMenuText(menuText: "Popular", backgroundColor: AppColors.primaryElement,  textColor: AppColors.primaryElementText),
           _reusableMenuText(menuText: "Newest", backgroundColor: Colors.transparent, textColor: AppColors.primaryThirdElementText),
          ],
        ),
      ),

    ],
  );
}

Widget _reusableText(
  String text, 
      {
        Color color = AppColors.primaryText,
        int fontSize = 16,
        FontWeight fontWeight = FontWeight.bold
      }
){
  return  Container(
              child: Text(
                text,
                style: TextStyle(
                          color: color,
                          fontWeight: fontWeight,
                          fontSize: fontSize.sp
                        ),
              ),
            );
}

Widget _reusableMenuText({String menuText = 'Default Text', Color backgroundColor = AppColors.primaryElement, Color textColor = AppColors.primaryElementText}){
  return  Container(
    margin: EdgeInsets.only(right: 20.w),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(7.w),
                border: Border.all(color: backgroundColor)
              ),
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
              child: _reusableText(menuText, color: textColor, fontWeight: FontWeight.normal, fontSize: 11),
            );
}
