import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_events.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_states.dart';

class CourseDetailBlocs extends Bloc<CourseDetailEvents, CourseDetailStates>{
  CourseDetailBlocs(): super(const CourseDetailStates()){
    on<TriggerCourseDetailEvent>(_triggerCourseDetail);
  }

  void _triggerCourseDetail(TriggerCourseDetailEvent event, Emitter<CourseDetailStates> emit){
    emit(state.copyWith(courseItem: event.courseItem));
  }
}