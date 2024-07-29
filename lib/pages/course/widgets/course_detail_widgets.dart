// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widget/base_text_widget.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_states.dart';

AppBar buildAppBar({required String text}){
  return AppBar(
    centerTitle: true,
    title: reusableText(text)
  );
}

String processThumbnailUrl(String url) {
  if (url.contains('firebasestorage')) {
    return url.replaceFirst('http://10.64.66.167:8000/uploads/', '');
  }

  debugPrint('Hendie - url : $url');
  return url;
}

Widget thumbnail({required CourseDetailStates courseDetailStates}) {
  return Container(
    width: 325.w,
    height: 200.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      image: (courseDetailStates.courseItem != null && courseDetailStates.courseItem!.thumbnail != null)
              ? 
                DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(courseDetailStates.courseItem!.thumbnail!), 
                )
              :
                null, 
    ),
    child: courseDetailStates.courseItem == null
            ? 
              Center(child: Text("No image available")) 
            : 
              null,
  );
}

Widget menuView(){
  return SizedBox( 
    width: 325.w,
    child: Row(
      children: [

        GestureDetector(
          onTap: (){},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: AppColors.primaryElement)
            ),
            child: reusableText(
                      "Author Page",
                      color: AppColors.primaryBackground,
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp
                    )
          ),
        ),

        _iconAndNum("assets/icons/people.png", 0),
        _iconAndNum("assets/icons/star.png", 0)

      ],
    ),
  );
}

Widget _iconAndNum(String iconPath, int num){
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [

        Image(
          image: AssetImage(iconPath),
          width: 20.w,
          height: 20.h,
        ),

        reusableText(
          num.toString(),
          color: AppColors.primaryThirdElementText,
          fontSize: 11.sp,
          fontWeight: FontWeight.normal
        )

      ],
    ),
  );
}

Widget goBuyButton(String name){
  return Container(
            width: 330.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                          color: AppColors.primaryElement,
                          borderRadius: BorderRadiusDirectional.circular(15.w),
                          border: Border.all(color: AppColors.primaryElement)
                        ),
            child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                                color: AppColors.primaryBackground,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal
                              ),
                  ),
          );
}

Widget descriptionText(){
  return  reusableText(
                "BLoC could also be used for routing. But one may disagree that, we must use BLoC for separating the business logic from UI. Personally I think it's not gonna hurt the performance and add extra code in your lib. On the other hand, if you use a plugin to do it, you will have a lot of extra code. And version control is also a problem. In fact, there are not good routing plugins out there apart from go_router and Getx routing. Some people don't wanna use Getx and go_routing is not complete yet. So I decided to go ahead with BLoC routing.",
                color: AppColors.primaryThirdElementText,
                fontWeight: FontWeight.normal,
                fontSize: 11.sp
              );
}

Widget courseSummaryTitle(){
  return reusableText(
            "The Course Includes",
            fontSize: 14.sp,
          );
}

Widget courseSummaryView(BuildContext context, CourseDetailStates state){ 

  var imagesInfoCourse = <String, String>{
        "${ (state.courseItem != null) ? state.courseItem!.video_length.toString() : '0' } Hours Video": "video_detail.png",
        "Total ${ (state.courseItem != null) ? state.courseItem!.lesson_num.toString() : '0'} Lessons": "file_detail.png",
        "${ (state.courseItem != null) ? state.courseItem!.down_num.toString() : '0' } Downloadable Resources":"download_detail.png",
      };

  return Column(
    children: [

      ...List.generate(imagesInfoCourse.length, (index) => 

        GestureDetector(
          // ignore: avoid_returning_null_for_void
          onTap: () => null,
          child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: Row(
                    children: [
                      
                      Container(
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      color: AppColors.primaryElement
                                    ),
                        child: Image.asset(
                                  "assets/icons/${imagesInfoCourse.values.elementAt(index)}",
                                  width: 30.w,
                                  height: 30.h,
                                ),
                      ),

                      SizedBox(
                        width: 15.w,
                      ),

                      Text(
                        imagesInfoCourse.keys.elementAt(index),
                        style: TextStyle(
                          color: AppColors.primarySecondaryElementText,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp
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

Widget courseLessonList(CourseDetailStates state){
  return SingleChildScrollView(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: state.lessonItem.length,
      itemBuilder: (context, index) {

        return Container(
                  margin: EdgeInsets.only(top: 10.h),
                  width: 325.w,
                  height: 80.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0,1)
                                  )
                                ]
                             ),
                  child: InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(
                              AppRoutes.LESSON_DETAIL, 
                              arguments: {
                               "id" : state.lessonItem[index].id
                              }
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              // for image and the text
                              Row(
                                children: [

                                  Container(
                                    width: 60.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.h),
                                                    image: DecorationImage(
                                                              fit: BoxFit.fitHeight,
                                                              image: NetworkImage(processThumbnailUrl(state.lessonItem[index].thumbnail!)), 
                                                            )
                                                  ),
                                  ),
                              
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                        _listContainer(
                                          state.lessonItem[index].name.toString(),
                                            fontSize: 13.sp, 
                                            color: AppColors.primaryText, 
                                            fontWeight: FontWeight.bold
                                          ),

                                        _listContainer(
                                          state.lessonItem[index].description.toString(),
                                            fontSize: 10.sp, 
                                            color: AppColors.primaryThirdElementText, 
                                            fontWeight: FontWeight.normal
                                        )
                                    ],
                                  )
                              
                                ],
                              ),
                           
                              // for showing the right arrow 
                              Container(
                                child: Image(
                                  width: 24.w,
                                  height: 24.h,
                                  image: AssetImage("assets/icons/arrow_right.png"),
                                ),
                              )
        
                            ],
                          ),
                  ),
                );
      }
    ),
  );
}

Widget _listContainer(
  String name,
  {required double fontSize, required Color color, required FontWeight fontWeight}
){
    return Container(
              width: 200.w,
              margin: EdgeInsets.only(left: 6.w),
              child: Text(
                      name,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
                    ),
            );
}




