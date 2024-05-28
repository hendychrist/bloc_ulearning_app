import 'package:ulearning_app/common/entities/entities.dart';

class CourseStates{
  final CourseItem? courseItem;

  const CourseStates({this.courseItem});

  CourseStates copyWith({ CourseItem? courseItem}){
    return CourseStates(
              courseItem: courseItem ?? this.courseItem,
            );
  }
}