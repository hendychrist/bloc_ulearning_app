// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_events.dart';

class CourseDetailController{
  final BuildContext context;

  CourseDetailController({required this.context});

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAllData(args["id"]);
  }

  asyncLoadAllData(int? id) async {
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.courseDetail(params: courseRequestEntity);

    if(result.code == 200){
      if(context.mounted){
        context.read<CourseDetailBlocs>().add(TriggerCourseDetailEvent(result.data!));
      }else{ 
        debugPrint('--------- Context is not available ---------');  
      }
    }else{
      toastInfo(msg: "Something went wrong");
      debugPrint('--------- Error code ${result.code} ---------');
    } 

  }

}