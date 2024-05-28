import 'package:ulearning_app/common/entities/entities.dart';

abstract class CourseEvents{
  const CourseEvents();
}

class TriggerCourseDetail extends CourseEvents{
  final CourseItem courseItem;
  const TriggerCourseDetail(this.courseItem): super();
}
