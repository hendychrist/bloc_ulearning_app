import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widget/base_text_widget.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_states.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail_controller.dart';
import 'package:ulearning_app/pages/course/widgets/course_detail_widgets.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late CourseDetailController _courseDetailController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _courseDetailController = CourseDetailController(context: context);
    _courseDetailController.init();
  }

  @override
  Widget build(BuildContext context) {

    // debugPrint('screen -');
    // debugPrint('screen - Screen Until');
    // debugPrint('screen - 100w : ${360.w}');
    // debugPrint('screen - 100h : ${690.h}');
    // debugPrint('screen -');
    // debugPrint('screen - vertical : ${15.h}');
    // debugPrint('screen - horizontal : ${25.w}');
    // debugPrint('screen -');

    return BlocBuilder<CourseDetailBlocs, CourseDetailStates>(
      builder: (context, state) {

        // debugPrint('---my items ${state.courseItem.description.toString()}');

        return Container(
          color: Colors.cyan,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBarCourse(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
          
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
          
                          // first big image
                          thumbnail(courseDetailStates: state),
                          SizedBox(height: 15.h,),
          
                          // three buttons or menus 
                          menuView(),
                          SizedBox(height: 15.h,),
          
                          // course description title
                          reusableText("Course Description"),
                          SizedBox(height: 15.h,),
          
                          // course description
                          descriptionText(),
                          SizedBox(height: 20.h,),
          
                          // course buy button
                          goBuyButton("Go Buy"),
                          SizedBox(height: 20.h,),
          
                          courseSummaryTitle(),
          
                          // course summary in list
                          courseSummaryView(context),
                          SizedBox(height: 20.h),
          
                          // Lesson list title 
                          reusableText("Lesson List"),
                          SizedBox(height: 20.h),
          
                          courseLessonList()
                          
                        ], 
                      ),
                    )
                    
          
                  ],
                ),
              )
          
            ),
          ),
        );
    
      }
    );
  
  }
}