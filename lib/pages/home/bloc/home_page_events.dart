import 'package:ulearning_app/common/entities/entities.dart';

abstract class HomePageEvents{
  const HomePageEvents();
}

class HomePageDots extends HomePageEvents{
  final int index;
  const HomePageDots(this.index);
}

class HomePageCourseItem extends HomePageEvents{
  const HomePageCourseItem(this.courseItem);
  final List<CourseItem> courseItem;
}