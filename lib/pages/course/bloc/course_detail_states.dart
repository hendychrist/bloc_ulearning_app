import 'package:ulearning_app/common/entities/entities.dart';

class CourseDetailStates{
  final CourseItem? courseItem;

  const CourseDetailStates({this.courseItem});

  CourseDetailStates copyWith({ CourseItem? courseItem}){
    return CourseDetailStates(
              courseItem: courseItem ?? this.courseItem,
            );
  }
}