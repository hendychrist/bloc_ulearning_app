// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/apis/course_api.dart';
import 'package:ulearning_app/common/apis/lesson_api.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_blocs.dart' as bloc;
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_events.dart' as event;

class CourseDetailController {
  final BuildContext context;

  CourseDetailController({required this.context});

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    await asyncLoadCourseData(args["id"]);
    await asyncLoadLessonData(args["id"]);
    // await asyncLoadCourseBought(args['id']);
  }

  asyncLoadCourseData(int? id) async {
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.courseDetail(params: courseRequestEntity);

    if(result.code ==200){
      if(context.mounted){
        print('---------context is ready------');
        context.read<bloc.CourseDetailBlocs>().add(event.TriggerCourseDetail(result.data!));
      }else{
        print('-------context is not available-------');
      }
 
    }else{
      toastInfo(msg: "Something went wrong and check the log in the laravel.log");
    }
  }

  asyncLoadLessonData(int? id) async {
    LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonList(params:lessonRequestEntity);
    if(result.code==200){
      if(context.mounted){
        context.read<bloc.CourseDetailBlocs>().add(event.TriggerLessonList(result.data!));
        print('Hendie - API: LessonAPI.lessonList \nlessonmy lesson data is :${result.data}');
      }else{
        print('Hendie - DEBUG ERROR : ----context is not read ----');
        toastInfo(msg: "Something went wrong,\nPlease Try again later");
      }
    }else{
      print('Hendie - DEBUG ERROR : LessonAPI.lessonList != 200 ${result.code}');
      toastInfo(msg: "Something went wrong,\nPlease Try again later");
    }

  }



  Future<void> goBuy(int? id) async {

    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    CourseRequestEntity courseRequestEntity= CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.coursePay(params: courseRequestEntity);
    EasyLoading.dismiss();
    if(result.code==200){
      //cleaner format of url
      var url = Uri.decodeFull(result.data!);

      var res = await Navigator.of(context).pushNamed(AppRoutes.PAY_WEB_VIEW, arguments: {
        "url":url
      });

      if(res=="success"){
        toastInfo(msg: "You bought it successfully");
      }
     // print('----my returned stripe url is $url--------');
    }else{
      toastInfo(msg: result.msg ?? "result.msg is null");
    }
  }

/*
  Future<void> asyncLoadCourseBought(int? id)async {

    CourseRequestEntity courseRequestEntity= CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.courseBought(params: courseRequestEntity);
    if(result.code==200){
     if(result.msg=="success"){
       if(context.mounted){
         context.read<bloc.CourseDetailBlocs>().add(const event.TriggerCheckBuy(true));
       }
     }else{
       if(context.mounted){
         context.read<bloc.CourseDetailBlocs>().add(const event.TriggerCheckBuy(false));
       }
     }
    }
  }
*/

}
