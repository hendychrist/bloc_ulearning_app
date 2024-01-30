// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/global.dart';

class HttpUtil{
  late Dio dio;
  
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil(){
    return _instance;
  }

  HttpUtil._internal(){
    BaseOptions options = BaseOptions(
                              baseUrl: AppConstants.SERVER_API_URL, // "http://127.0.0.1:8000",
                              connectTimeout: Duration(seconds: 30),      
                              receiveTimeout: Duration(seconds: 30), // waiting for response after getting connection
                              headers: {},
                              contentType: "application/json: charset=utf-8",
                              responseType: ResponseType.json
                            );
    dio = Dio(options);
  }

  Future post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, bool isLogin = false}) async {
    Map<String, dynamic>? authorization;
    
    if(options == null && isLogin == false){
      authorization = getAuthorizationHeader();
      
      if(authorization == null){
        toastInfo(msg: 'post() -> authorization is null');
      }
    }

    var response = await dio.post(
                                path,
                                data: data,
                                queryParameters: queryParameters,
                                options: options ?? Options(
                                                        headers: authorization,
                                                      ),
                            );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent.
          // If you want to resolve the request with custom data,
          // you can resolve a `Response` using `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject with a `DioException` using `handler.reject(dioError)`.
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          // Do something with response data.
          // If you want to reject the request with a error message,
          // you can reject a `DioException` object using `handler.reject(dioError)`.
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          return handler.next(error);
        },
      ),
    );

    // print("DEBUG: http_utils.dart -> post() -> STATUS  CODE : ${response.statusCode}");
    // print("DEBUG: http_utils.dart -> post() -> RESPONSE : ${response.toString()}");
    
    // return object  
    return response.data;
  }


   Map<String,dynamic> getAuthorizationHeader(){
    Map<String,dynamic> header = <String, dynamic>{};
    String accessToken = Global.storageService.getUserToken();
    String modifiedAccessToken = accessToken.substring(3);

    if(accessToken.isNotEmpty){
      header['Authorization'] = 'Bearer $modifiedAccessToken';
    }else{
      toastInfo(msg: "getAuthorizationHeader() -> accessToken() is Empty");
    }
    return header;
  }


}