import 'package:dio/dio.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/utils/http_utils.dart';

class CourseAPI{
  
  final dio = Dio();

  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post(
                                      'api/courseList'
                                    );
    // print('course_api - response : $response');

    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseDetailResponseEntity> courseDetail({required CourseRequestEntity params}) async {
    var response = await HttpUtil().post(
                                      'api/courseDetail',
                                      queryParameters: params.toJson(),
                                    );
  
    // print('course_api - response : ${response.toString()}');

    return CourseDetailResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> coursePay({CourseRequestEntity? params}) async {
    final dio = Dio();

    dio.options.headers["Authorization"] = "Bearer 154|x8xG6tBZZH09dVZzOXX20bH3KcjJA0ANxL7DrPG83aa1ab25";
    dio.options.validateStatus = (status){
      return status != null && status < 500;
    };

    try {
      var response = await dio.post(
        'http://10.64.66.167:8000/api/checkout',
        queryParameters: params?.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        return BaseResponseEntity.fromJson(response.data);
      }
   /*     else if (response.statusCode == 400) {
        return BaseResponseEntity(
          code: 400,
          msg: response.data['msg'],
          data: response.data,
        );
      }  */
      else if (response.statusCode == 500) {
        return BaseResponseEntity(
          code: 500,
          msg: "Internal Server Error",
          data: response.data,
        );
      } else {
        return BaseResponseEntity(
          code: response.statusCode ?? 0,
          msg: response.statusMessage ?? "Unknown error",
          data: response.data,
        );
      }
    } catch (e) {
      // Handle exceptions
      return BaseResponseEntity(
        code: 0,
        msg: e.toString(),
        data: null,
      );
    }
  }

/*
  //for checking one item bought
  static Future<BaseResponseEntity> courseBought({CourseRequestEntity? params}) async {
    var response=  await HttpUtil().post(
      'api/courseBought',
      queryParameters: params?.toJson(),
    );

    return BaseResponseEntity.fromJson(response);
  }
*/

}
