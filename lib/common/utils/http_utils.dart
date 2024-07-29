// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_print

import 'dart:io';

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
        onResponse: (response, responseInterceptorHandler) async {
          print('DioObserver - onResponse - ${response.statusCode} - ${response.data.toString()}\n');
          return responseInterceptorHandler.next(response);
        },
        onRequest: (request, requestInterceptorHandler) {
          print("DioObserver - onRequest - ${request.method} - ${request.path} - ${request.data}");
          print("DioObserver - onRequest - ${ authorization ?? "authorization is empty" }");
        
          // request.headers.addAll({HttpHeaders.authorizationHeader: 'Bearer 156|JnZfLV8MVvDQ4M60Tj0voIMRCL662fYXnQtPFuuW34f8c286'});
          request.headers.addAll(authorization ?? {HttpHeaders.authorizationHeader: 'Bearer 156|JnZfLV8MVvDQ4M60Tj0voIMRCL662fYXnQtPFuuW34f8c286'});

          return requestInterceptorHandler.next(request);
        },

        onError: (DioException error, errorInterceptor) {
          print("DioObserver - onError - ${error.message}");

          return errorInterceptor.next(error);
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
    // String modifiedAccessToken = accessToken.substring(3);

    if(accessToken.isNotEmpty){
      header['Authorization'] = 'Bearer $accessToken';
    }else{
      toastInfo(msg: "getAuthorizationHeader() -> accessToken() is Empty");
    }
    return header;
  }


}