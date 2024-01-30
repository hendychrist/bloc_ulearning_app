import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/course/bloc/course_detail_events.dart';
import 'package:ulearning_app/pages/course/bloc/course_detail_states.dart';

class CourseDetailBlocs extends Bloc<CourseDetailEvents, CourseDetailStates>{
  CourseDetailBlocs(): super(const CourseDetailStates()){
    on<TriggerCourseDetail>(_triggerCourseDetail);
  }

  void _triggerCourseDetail(TriggerCourseDetail event, Emitter<CourseDetailStates> emit){
    emit(state.copyWith(courseItem: event.courseItem));
  }
}