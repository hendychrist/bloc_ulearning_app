import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/course/bloc/course_events.dart';
import 'package:ulearning_app/pages/course/bloc/course_states.dart';

class CourseBlocs extends Bloc<CourseEvents, CourseStates>{
  CourseBlocs(): super(const CourseStates()){
    on<TriggerCourseDetail>(_triggerCourseDetail);
  }

  void _triggerCourseDetail(TriggerCourseDetail event, Emitter<CourseStates> emit){
    emit(state.copyWith(courseItem: event.courseItem));
  }
}