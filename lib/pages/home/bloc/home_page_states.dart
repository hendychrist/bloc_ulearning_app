import 'package:ulearning_app/common/entities/entities.dart';

class HomePageStates{
  final int index;
  final List<CourseItem> courseItem;

  const HomePageStates({this.index = 0, this.courseItem = const <CourseItem>[]});

  HomePageStates copyWith({int? index, List<CourseItem>? courseItem}){
    return HomePageStates(
      courseItem: courseItem ?? this.courseItem,
      index: index ?? this.index
    );
  }
}