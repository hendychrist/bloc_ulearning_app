// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widget/base_text_widget.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_bloc.dart';

AppBar buildAppbar(){
  return AppBar(
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          SizedBox(
            width: 18.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png"),
          ),

          Text(
            "Profile",
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp
            ),
          ),

          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset("assets/icons/more-vertical.png"),
          ),

        ],
      ),
    ),
  );
}

// profile icon and edit button
Widget profileIconAndEditButton(){
  return Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.only(right: 6.w),
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            image: const DecorationImage(image: AssetImage("assets/icons/headpic.png"))
          ),
          child: Image(
            width: 25.w,
            height: 25.h,
            image: const AssetImage("assets/icons/edit_3.png"),
          ),
        );    
}

var imagesInfo = <String, String>{
  "Settings": "settings.png",
  "Payment details": "credit-card.png",
  "Achievement":"award.png",
  "Love":"heart(1).png",
  "Reminders":"cube.png"
};

Widget buildListView(BuildContext context){ 
  return Column(
    children: [

      ...List.generate(imagesInfo.length, (index) => 

        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.SETTINGS),
          child: Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  child: Row(
                    children: [
                      
                      Container(
                        width: 40.w,
                        height: 40.h,
                        padding: const EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: AppColors.primaryElement
                        ),
                        child: Image.asset("assets/icons/${imagesInfo.values.elementAt(index)}"),
                      ),

                      SizedBox(
                        width: 15.w,
                      ),

                      Text(
                        imagesInfo.keys.elementAt(index),
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                        ),
                      ),

                    ],
                  )
                )
              )
    
      )


    ],
  );
}

Widget buildRowView(BuildContext context){
    return Container(
              alignment: Alignment.center,
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        _rowView(
                            imagePath: "assets/icons/profile_video.png", 
                            text: "My Courses",
                            func: (){
                                    debugPrint("DEBUG: My Courses");
                                   }
                          ),

                        _rowView(
                            imagePath: "assets/icons/profile_book.png", 
                            text: "Buy Courses",
                            func: (){
                                    debugPrint("DEBUG: Buy Courses");
                                   }
                        ),

                        _rowView(
                            imagePath: "assets/icons/profile_star.png", 
                            text: "4.9",
                            func: (){
                                    debugPrint("DEBUG: Rating * star");
                                   }
                        ),
                      ],
                    ),
            );

}

Widget _rowView({required String imagePath, required String text, void Function()? func}){
  return  GestureDetector(
    onTap: func,
    child: Container(
              width: 100.w,
              padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
              decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 3)
                                )
                              ],
                              borderRadius: BorderRadius.circular(15.w),
                              border: Border.all(color: AppColors.primaryElement)
                            ),
              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                    
                            SizedBox(
                              width: 20.w,
                              height: 20.w,
                              // ignore: unnecessary_string_interpolations
                              child: Image.asset("$imagePath"),
                            ),
                    
                            Container( 
                              child: reusableText(
                                        text, 
                                        fontSize: 11.sp, 
                                        color: AppColors.primaryElementText,
                                        fontWeight: FontWeight.bold
                                    ),
                            )
                          ],
                        ),
            
            ),
  );
}

Widget buildProfileName(ProfileStates state){
        return state.userProfile == null 
                              ? 
                                Container(
                                  child: reusableText("No Name Found"),
                                )
                              :
                                Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.only(
                                                left: 50.w,
                                                right: 50.w
                                              ),
                                  margin: EdgeInsets.only(bottom: 10.h, top: 5.h),
                                  child: Text(
                                            state.userProfile?.description ?? "No name given",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                      color: AppColors.primarySecondaryElementText,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                          ),
                                 );

}