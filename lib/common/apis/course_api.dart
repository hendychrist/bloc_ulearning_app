
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class CourseAPI{

  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post('api/courseList');
    // print('course_api - response : $response');

    return CourseListResponseEntity.fromJson(response);
  }
  
}