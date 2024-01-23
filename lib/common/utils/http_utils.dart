// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:ulearning_app/common/values/constant.dart';

class HttpUtil{
  late Dio dio;
  
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil(){
    return _instance;
  }

  HttpUtil._internal(){
    BaseOptions options = BaseOptions(
                              // baseUrl: "http://127.0.0.1:8000",
                              baseUrl: AppConstants.SERVER_API_URL,
                              connectTimeout: Duration(seconds: 300),      
                              receiveTimeout: Duration(seconds: 300), // waiting for response after getting connection
                              headers: {},
                              contentType: "application/json: charset=utf-8",
                              responseType: ResponseType.json
                            );
    dio = Dio(options);
  }

  Future post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    var response = await dio.post(
                                path,
                                data: data,
                                queryParameters: queryParameters,
                            );

    print("DEBUG: http_utils.dart -> post() -> my response data is : ${response.toString()}");

    // return object  
    return response.data;
  }

}