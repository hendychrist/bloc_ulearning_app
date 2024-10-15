// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ulearning_app/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_events.dart';
import 'package:ulearning_app/pages/course/lesson/bloc/lesson_states.dart';
import 'package:ulearning_app/pages/course/lesson/lesson_controller.dart';
import 'package:ulearning_app/pages/course/lesson/widgets/lesson_detail_widget.dart';
import 'package:ulearning_app/pages/course/widgets/course_detail_widgets.dart' as course;

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  late LessonController _lessonController;
  int videoIndex = 0;

  @override
  void didChangeDependencies() {
    _lessonController = LessonController(context: context);

    // have to set url to null. unless it will create the url and a lot of wired thing will happen
    context.read<LessonBlocs>().add(const TriggerUrlItem(null)); // restart everything
    context.read<LessonBlocs>().add(const TriggerVideoIndex(0));

    _lessonController.init();
    super.didChangeDependencies();
  }

  // Play video takes a lot of memory, if we dont dispose it make the memory leaks and eventually app will shutdown
  @override
  void dispose() {
    _lessonController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBlocs, LessonStates>(
      builder: (context, state){
        return SafeArea(

          child: Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.white,
              // appBar: buildAppBar("Lesson Detail", onPressed: () => Navigator.pop(context) ),
              appBar: course.buildAppBar(text: "Lesson Detail"),
              body: CustomScrollView(
                slivers: [

                  SliverPadding(
                          padding: EdgeInsets.symmetric(
                                                  vertical: 20.h,
                                                  horizontal: 25.w,
                                                ),
                          sliver: SliverToBoxAdapter(
                            child: Container(
                              child: Column(
                                children: [

                                  // Video Preview
                                  videoPlayer(state, _lessonController),

                                  // Video Button
                                  videoControls(state, _lessonController, context)
                          
                                ],
                              ),
                            ),
                          ),
                  ),

                  videoList(state, _lessonController),
                ],
              )
            ),
          ),
        );
      }
    );
  }

}


